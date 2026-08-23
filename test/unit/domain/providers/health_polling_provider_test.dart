import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_datasource.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/repositories/server_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

void main() {
  const healthy = ServerHealth(healthy: true, version: '1.0.0');
  const unhealthy = ServerHealth(healthy: false, version: '2.0.0');
  const nextHealthy = ServerHealth(healthy: true, version: '3.0.0');

  final connected = AppConnectionState(
    status: ConnectionStatus.connected,
    baseUrl: 'http://127.0.0.1:4096',
    displayName: '127.0.0.1:4096',
    health: healthy,
  );

  ProviderContainer makeContainer(
    _PollingStub repository, {
    AppConnectionState connection = const AppConnectionState(),
    bool mutableConnection = false,
  }) {
    final container = ProviderContainer(
      overrides: [
        if (mutableConnection)
          connectionProvider.overrideWith(() => _MutableConnection(connection))
        else
          connectionProvider.overrideWithValue(connection),
        serverRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  ProviderSubscription<AsyncValue<ServerHealth>> listen(
    ProviderContainer container,
  ) {
    return container.listen(healthPollingProvider, (_, _) {});
  }

  /// Disposes the container and lets any pending poll-delay timer fire so
  /// flutter_test's pending-timer invariant stays satisfied.
  Future<void> settle(WidgetTester tester, ProviderContainer container) async {
    container.dispose();
    await tester.pump(const Duration(seconds: 31));
  }

  group('healthPollingProvider', () {
    testWidgets(
      'disconnected connection emits no health and makes zero requests',
      (tester) async {
        final repository = _PollingStub();
        final container = makeContainer(repository);
        final subscription = listen(container);

        await tester.pump();

        expect(subscription.read().value, isNull);
        expect(repository.calls, 0);

        await tester.pump(const Duration(minutes: 5));
        expect(repository.calls, 0);

        await settle(tester, container);
      },
    );

    testWidgets('connected state immediately emits the connection snapshot '
        'without a duplicate request', (tester) async {
      final repository = _PollingStub();
      final container = makeContainer(repository, connection: connected);
      final subscription = listen(container);

      await tester.pump();

      expect(subscription.read().value, healthy);
      expect(repository.calls, 0);

      await settle(tester, container);
    });

    testWidgets(
      'makes no request before 30 seconds and exactly one at 30 seconds',
      (tester) async {
        final repository = _PollingStub();
        final container = makeContainer(repository, connection: connected);
        container.listen(healthPollingProvider, (_, _) {});
        await tester.pump();

        await tester.pump(const Duration(seconds: 29));
        expect(repository.calls, 0);

        await tester.pump(const Duration(seconds: 1));
        expect(repository.calls, 1);
        expect(repository.tokens, hasLength(1));

        await settle(tester, container);
      },
    );

    testWidgets(
      'successful responses replace health and version across transitions',
      (tester) async {
        final repository = _PollingStub()..script.addAll([unhealthy]);
        final container = makeContainer(repository, connection: connected);
        final subscription = listen(container);
        await tester.pump();

        await tester.pump(const Duration(seconds: 30));
        await tester.pump();
        expect(subscription.read().value, unhealthy);

        repository.script.add(nextHealthy);
        await tester.pump(const Duration(seconds: 30));
        await tester.pump();
        expect(subscription.read().value, nextHealthy);

        await settle(tester, container);
      },
    );

    testWidgets(
      'a repository failure yields AsyncError, keeps the previous value and '
      'the connection, and recovers on the next interval',
      (tester) async {
        final repository = _PollingStub()
          ..script.add(const NetworkException('down'))
          ..script.add(nextHealthy);
        final container = makeContainer(repository, connection: connected);
        final subscription = listen(container);
        await tester.pump();

        await tester.pump(const Duration(seconds: 30));
        await tester.pump();

        final errored = subscription.read();
        expect(errored.hasError, isTrue);
        expect(errored.value, healthy);
        expect(
          container.read(connectionProvider).status,
          ConnectionStatus.connected,
        );

        await tester.pump(const Duration(seconds: 30));
        await tester.pump();
        expect(subscription.read().value, nextHealthy);
        expect(subscription.read().hasError, isFalse);

        await settle(tester, container);
      },
    );

    testWidgets(
      'a slow request prevents overlapping calls and the next request waits '
      'a full interval after completion',
      (tester) async {
        final repository = _PollingStub();
        final container = makeContainer(repository, connection: connected);
        final subscription = listen(container);
        await tester.pump();

        final pending = Completer<ServerHealth>();
        repository.pendingResponse = pending;

        await tester.pump(const Duration(seconds: 30));
        expect(repository.calls, 1);

        await tester.pump(const Duration(seconds: 60));
        expect(repository.calls, 1);

        pending.complete(unhealthy);
        await tester.pump();
        expect(subscription.read().value, unhealthy);

        await tester.pump(const Duration(seconds: 29));
        expect(repository.calls, 1);
        await tester.pump(const Duration(seconds: 1));
        expect(repository.calls, 2);

        await settle(tester, container);
      },
    );

    testWidgets(
      'disconnecting cancels the active token and prevents all further '
      'requests',
      (tester) async {
        final repository = _PollingStub();
        final container = makeContainer(
          repository,
          connection: connected,
          mutableConnection: true,
        );
        container.listen(healthPollingProvider, (_, _) {});
        await tester.pump();

        final pending = Completer<ServerHealth>();
        repository.pendingResponse = pending;

        await tester.pump(const Duration(seconds: 30));
        expect(repository.calls, 1);
        final token = repository.tokens.single;
        expect(token.isCancelled, isFalse);

        await container.read(connectionProvider.notifier).disconnect();
        await tester.pump();

        expect(token.isCancelled, isTrue);

        await tester.pump(const Duration(minutes: 2));
        expect(repository.calls, 1);

        await settle(tester, container);
      },
    );

    testWidgets(
      'disposing the container cancels the active token without surfacing '
      'a health error',
      (tester) async {
        final repository = _PollingStub();
        final container = makeContainer(repository, connection: connected);
        container.listen(healthPollingProvider, (_, _) {});
        await tester.pump();

        final pending = Completer<ServerHealth>();
        repository.pendingResponse = pending;

        await tester.pump(const Duration(seconds: 30));
        expect(repository.calls, 1);
        final token = repository.tokens.single;

        container.dispose();

        expect(token.isCancelled, isTrue);

        await settle(tester, container);
      },
    );
  });
}

class _PollingStub extends ServerRepository {
  _PollingStub() : super(ServerDatasource(Dio()));

  final List<CancelToken> tokens = [];
  final List<Object> script = [];
  Completer<ServerHealth>? pendingResponse;
  int calls = 0;

  @override
  Future<ServerHealth> getHealth({CancelToken? cancelToken}) {
    calls++;
    tokens.add(cancelToken!);
    final pending = pendingResponse;
    if (pending != null) {
      return pending.future;
    }
    if (script.isNotEmpty) {
      final next = script.removeAt(0);
      if (next is AppException) {
        return Future.error(next);
      }
      return Future.value(next as ServerHealth);
    }
    return Future.value(const ServerHealth(healthy: true, version: 'default'));
  }
}

class _MutableConnection extends Connection {
  _MutableConnection(this._initial);

  final AppConnectionState _initial;

  @override
  AppConnectionState build() => _initial;
}
