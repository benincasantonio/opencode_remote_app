import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_datasource.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/repositories/server_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/dio_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

void main() {
  group('Connection.connect', () {
    test('sets connected state with health on success', () async {
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
              health: const ServerHealth(healthy: true, version: '1.2.3'),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container
          .read(connectionProvider.notifier)
          .connect(host: '192.168.1.10', port: 4096);

      final state = container.read(connectionProvider);
      expect(state.status, ConnectionStatus.connected);
      expect(state.baseUrl, 'http://192.168.1.10:4096');
      expect(state.displayName, '192.168.1.10:4096');
      expect(state.health?.version, '1.2.3');
      expect(container.read(isConnectedProvider), isTrue);
      expect(client.dio.options.baseUrl, 'http://192.168.1.10:4096');
    });

    test('sets error state on AppException', () async {
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
              error: const AuthException('Unauthorized', statusCode: 401),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(connectionProvider.notifier).connect(
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

    test('sets connecting while the health request is in flight', () async {
      final client = DioClient(
        baseUrl: 'http://127.0.0.1:4096',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      final completer = Completer<ServerHealth>();
      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWithValue(client),
          serverRepositoryProvider.overrideWithValue(
            _StubServerRepository(pending: completer.future),
          ),
        ],
      );
      addTearDown(container.dispose);

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
  Future<ServerHealth> getHealth() {
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
