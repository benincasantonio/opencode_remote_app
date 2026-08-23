import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_datasource.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/repositories/server_repository.dart';

void main() {
  group('ServerRepository', () {
    test('forwards getHealth to the datasource', () async {
      final repository = ServerRepository(
        _FakeDatasource(const ServerHealth(healthy: true, version: '2.0.0')),
      );

      final health = await repository.getHealth();

      expect(health.version, '2.0.0');
      expect(health.healthy, isTrue);
    });

    test('forwards the exact optional CancelToken to the datasource', () async {
      final fake = _FakeDatasource(
        const ServerHealth(healthy: true, version: '2.0.0'),
      );
      final repository = ServerRepository(fake);
      final token = CancelToken();

      await repository.getHealth(cancelToken: token);

      expect(identical(fake.lastToken, token), isTrue);
    });

    test('omits the CancelToken when none is provided', () async {
      final fake = _FakeDatasource(
        const ServerHealth(healthy: true, version: '2.0.0'),
      );
      final repository = ServerRepository(fake);

      await repository.getHealth();

      expect(fake.lastToken, isNull);
    });

    test('propagates datasource failures', () async {
      final repository = ServerRepository(
        _FakeDatasource.error(const NetworkException('down')),
      );

      expect(() => repository.getHealth(), throwsA(isA<NetworkException>()));
    });
  });
}

class _FakeDatasource extends ServerDatasource {
  _FakeDatasource(this._health) : _error = null, super(Dio());

  _FakeDatasource.error(this._error) : _health = null, super(Dio());

  final ServerHealth? _health;
  final AppException? _error;

  CancelToken? lastToken;

  @override
  Future<ServerHealth> getHealth({CancelToken? cancelToken}) {
    lastToken = cancelToken;
    final error = _error;
    if (error != null) {
      return Future.error(error);
    }
    return Future.value(_health!);
  }
}
