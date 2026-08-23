import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/api_constants.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_datasource.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';

void main() {
  group('ServerDatasource.getHealth', () {
    test('parses a successful health response', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.path, ApiConstants.healthPath);
        return _jsonResponse(options, '{"healthy":true,"version":"1.2.3"}');
      });

      final health = await ServerDatasource(dio).getHealth();

      expect(health, const ServerHealth(healthy: true, version: '1.2.3'));
    });

    test('forwards the exact optional CancelToken to Dio', () async {
      final token = CancelToken();
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(identical(options.cancelToken, token), isTrue);
        return _jsonResponse(options, '{"healthy":true,"version":"1.2.3"}');
      });

      final health = await ServerDatasource(dio).getHealth(cancelToken: token);

      expect(health, const ServerHealth(healthy: true, version: '1.2.3'));
    });

    test('rethrows AppException from DioException.error', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) {
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                type: error.type,
                error: const AuthException('Unauthorized', statusCode: 401),
                response: error.response,
              ),
            );
          },
        ),
      );
      dio.httpClientAdapter = _Adapter((options) async {
        return ResponseBody.fromString(
          '{"error":true}',
          401,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      expect(
        () => ServerDatasource(dio).getHealth(),
        throwsA(isA<AuthException>()),
      );
    });

    test('throws ParseException for invalid JSON shape', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        return _jsonResponse(options, '{"ok":true}');
      });

      expect(
        () => ServerDatasource(dio).getHealth(),
        throwsA(isA<ParseException>()),
      );
    });
  });
}

typedef _RequestHandler = Future<ResponseBody> Function(RequestOptions options);

class _Adapter implements HttpClientAdapter {
  _Adapter(this._handler);

  final _RequestHandler _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

Future<ResponseBody> _jsonResponse(RequestOptions options, String body) async {
  return ResponseBody.fromString(
    body,
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}
