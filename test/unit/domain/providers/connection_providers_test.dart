import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_datasource.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/repositories/saved_server_repository.dart';
import 'package:opencode_remote_app/data/repositories/server_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/dio_providers.dart';
import 'package:opencode_remote_app/domain/providers/saved_server_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

import '../../../helpers/fake_saved_server_storage.dart';

void main() {
  group('Connection.connect', () {
    late FakeServerStorage savedStorage;
    late FakeCredentialStorage savedCredentials;

    ProviderContainer makeContainer({
      required ServerRepository serverRepository,
      List<SavedServer> savedServers = const [],
    }) {
      savedStorage = FakeServerStorage(savedServers);
      savedCredentials = FakeCredentialStorage();
      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWithValue(
            DioClient(baseUrl: 'http://127.0.0.1:4096', enableLogging: false),
          ),
          serverRepositoryProvider.overrideWithValue(serverRepository),
          savedServerRepositoryProvider.overrideWithValue(
            SavedServerRepository(savedStorage, savedCredentials),
          ),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    /// Waits until the fire-and-forget boot chain has finished.
    Future<void> waitForBoot(ProviderContainer container) async {
      for (var i = 0; i < 50; i++) {
        await container.pump();
        await Future<void>.delayed(Duration.zero);
        if (!container.read(connectionProvider).bootInProgress) {
          return;
        }
      }
      fail('boot auto-connect did not settle');
    }

    test('sets connected state with health on success', () async {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          health: const ServerHealth(healthy: true, version: '1.2.3'),
        ),
      );

      await container
          .read(connectionProvider.notifier)
          .connect(host: '192.168.1.10', port: 4096);

      final state = container.read(connectionProvider);
      expect(state.status, ConnectionStatus.connected);
      expect(state.baseUrl, 'http://192.168.1.10:4096');
      expect(state.displayName, '192.168.1.10:4096');
      expect(state.health?.version, '1.2.3');
      expect(container.read(isConnectedProvider), isTrue);
      expect(
        container.read(dioClientProvider).dio.options.baseUrl,
        'http://192.168.1.10:4096',
      );
    });

    test('persists the server on success', () async {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          health: const ServerHealth(healthy: true, version: '1.2.3'),
        ),
      );

      await container
          .read(connectionProvider.notifier)
          .connect(
            host: '192.168.1.10',
            port: 4096,
            username: 'u',
            password: 'p',
          );

      final saved = await savedStorage.getAll();
      expect(saved, hasLength(1));
      expect(saved.single.host, '192.168.1.10');
      expect(saved.single.port, 4096);
      expect((await savedCredentials.get(saved.single.id))?.username, 'u');
    });

    test('sets error state on AppException', () async {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          error: const AuthException('Unauthorized', statusCode: 401),
        ),
      );

      await container
          .read(connectionProvider.notifier)
          .connect(
            host: 'example.com',
            port: 4096,
            username: 'u',
            password: 'p',
          );

      final state = container.read(connectionProvider);
      expect(state.status, ConnectionStatus.error);
      expect(state.error, isA<AuthException>());
      expect(container.read(isConnectedProvider), isFalse);
    });

    test('does not persist when the connection fails', () async {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          error: const AuthException('Unauthorized', statusCode: 401),
        ),
      );

      await container
          .read(connectionProvider.notifier)
          .connect(host: 'example.com', port: 4096);

      expect(await savedStorage.getAll(), isEmpty);
    });

    test('sets connecting while the health request is in flight', () async {
      final completer = Completer<ServerHealth>();
      final container = makeContainer(
        serverRepository: _StubServerRepository(pending: completer.future),
      );

      final future = container
          .read(connectionProvider.notifier)
          .connect(host: 'host', port: 1);

      expect(
        container.read(connectionProvider).status,
        ConnectionStatus.connecting,
      );

      completer.complete(const ServerHealth(healthy: true, version: '0'));
      await future;

      expect(
        container.read(connectionProvider).status,
        ConnectionStatus.connected,
      );
    });

    test(
      'a second connect attempt is ignored while one is in flight',
      () async {
        final completer = Completer<ServerHealth>();
        final container = makeContainer(
          serverRepository: _StubServerRepository(pending: completer.future),
        );
        await waitForBoot(container);

        final first = container
            .read(connectionProvider.notifier)
            .connect(host: 'first-host', port: 1);
        expect(
          container.read(connectionProvider).status,
          ConnectionStatus.connecting,
        );

        final second = container
            .read(connectionProvider.notifier)
            .connect(host: 'second-host', port: 2);
        await second;

        expect(
          container.read(connectionProvider).displayName,
          'first-host:1',
          reason: 'first attempt keeps ownership of the in-flight connect',
        );

        completer.complete(const ServerHealth(healthy: true, version: '0'));
        await first;

        final state = container.read(connectionProvider);
        expect(state.status, ConnectionStatus.connected);
        expect(state.displayName, 'first-host:1');
        expect(state.baseUrl, 'http://first-host:1');
      },
    );

    test('retry after an error is still allowed', () async {
      final repository = _FlakyServerRepository();
      final container = makeContainer(serverRepository: repository);

      await container
          .read(connectionProvider.notifier)
          .connect(host: 'host', port: 1);
      expect(container.read(connectionProvider).status, ConnectionStatus.error);

      await container
          .read(connectionProvider.notifier)
          .connect(host: 'host', port: 1);

      expect(repository.calls, 2);
      expect(
        container.read(connectionProvider).status,
        ConnectionStatus.connected,
      );
    });
  });

  group('Connection.boot auto-connect', () {
    late FakeServerStorage savedStorage;
    late FakeCredentialStorage savedCredentials;

    ProviderContainer makeContainer({
      required ServerRepository serverRepository,
      List<SavedServer> savedServers = const [],
    }) {
      savedStorage = FakeServerStorage(savedServers);
      savedCredentials = FakeCredentialStorage();
      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWithValue(
            DioClient(baseUrl: 'http://127.0.0.1:4096', enableLogging: false),
          ),
          serverRepositoryProvider.overrideWithValue(serverRepository),
          savedServerRepositoryProvider.overrideWithValue(
            SavedServerRepository(savedStorage, savedCredentials),
          ),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    /// Waits until the fire-and-forget boot chain has finished.
    Future<void> waitForBoot(ProviderContainer container) async {
      for (var i = 0; i < 50; i++) {
        await container.pump();
        await Future<void>.delayed(Duration.zero);
        if (!container.read(connectionProvider).bootInProgress) {
          return;
        }
      }
      fail('boot auto-connect did not settle');
    }

    test('starts in a boot loading state', () {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          health: const ServerHealth(healthy: true, version: '0'),
        ),
      );

      final state = container.read(connectionProvider);
      expect(state.bootInProgress, isTrue);
      expect(state.status, ConnectionStatus.disconnected);
    });

    test(
      'connects to the default saved server with stored credentials',
      () async {
        savedCredentials.save('srv1', (username: 'user', password: 'pass'));
        final container = makeContainer(
          serverRepository: _StubServerRepository(
            health: const ServerHealth(healthy: true, version: '1.2.3'),
          ),
          savedServers: [
            SavedServer(
              id: 'srv1',
              host: '192.168.1.10',
              port: 4096,
              isDefault: true,
            ),
          ],
        );

        await waitForBoot(container);

        final state = container.read(connectionProvider);
        expect(state.status, ConnectionStatus.connected);
        expect(state.baseUrl, 'http://192.168.1.10:4096');
        expect(state.displayName, '192.168.1.10:4096');
        expect(state.bootInProgress, isFalse);
        expect(container.read(isConnectedProvider), isTrue);
      },
    );

    test('ends disconnected when no saved server exists', () async {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          health: const ServerHealth(healthy: true, version: '0'),
        ),
      );

      await waitForBoot(container);

      final state = container.read(connectionProvider);
      expect(state.status, ConnectionStatus.disconnected);
      expect(state.bootInProgress, isFalse);
      expect(container.read(isConnectedProvider), isFalse);
    });

    test('lands in error when the saved server is unreachable', () async {
      final container = makeContainer(
        serverRepository: _StubServerRepository(
          error: const NetworkException('Connection refused'),
        ),
        savedServers: [
          SavedServer(
            id: 'srv1',
            host: '192.168.1.10',
            port: 4096,
            isDefault: true,
          ),
        ],
      );

      await waitForBoot(container);

      final state = container.read(connectionProvider);
      expect(state.status, ConnectionStatus.error);
      expect(state.error, isA<NetworkException>());
      expect(state.bootInProgress, isFalse);
    });
  });

  group('Connection.disconnect', () {
    test('resets state and Dio configuration', () async {
      final client = DioClient(
        baseUrl: 'http://127.0.0.1:4096',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWithValue(client),
          serverRepositoryProvider.overrideWithValue(
            _StubServerRepository(
              health: const ServerHealth(healthy: true, version: '0'),
            ),
          ),
          savedServerRepositoryProvider.overrideWithValue(
            SavedServerRepository(FakeServerStorage(), FakeCredentialStorage()),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container
          .read(connectionProvider.notifier)
          .connect(host: 'host', port: 1);

      await container.read(connectionProvider.notifier).disconnect();

      final state = container.read(connectionProvider);
      expect(state.status, ConnectionStatus.disconnected);
      expect(state.baseUrl, isNull);
      expect(state.displayName, isNull);
      expect(state.health, isNull);
      expect(container.read(isConnectedProvider), isFalse);
      expect(client.dio.options.baseUrl, 'http://127.0.0.1:4096');
    });
  });
}

class _StubServerRepository extends ServerRepository {
  _StubServerRepository({
    this.health,
    this.error,
    Future<ServerHealth>? pending,
  }) : _pending = pending,
       super(ServerDatasource(Dio()));

  final ServerHealth? health;
  final AppException? error;
  final Future<ServerHealth>? _pending;

  @override
  Future<ServerHealth> getHealth({CancelToken? cancelToken}) {
    if (_pending != null) {
      return _pending;
    }
    final err = error;
    if (err != null) {
      return Future.error(err);
    }
    return Future.value(health!);
  }
}

class _FlakyServerRepository extends ServerRepository {
  _FlakyServerRepository() : super(ServerDatasource(Dio()));

  int calls = 0;

  @override
  Future<ServerHealth> getHealth({CancelToken? cancelToken}) {
    calls++;
    if (calls == 1) {
      return Future.error(const NetworkException('Connection refused'));
    }
    return Future.value(const ServerHealth(healthy: true, version: '1.2.3'));
  }
}
