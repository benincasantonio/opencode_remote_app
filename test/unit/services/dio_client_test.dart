import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/api_constants.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

void main() {
  group('DioClient construction', () {
    test('applies baseUrl and ApiConstants timeouts', () {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      expect(client.dio.options.baseUrl, 'http://example.com');
      expect(client.dio.options.connectTimeout, ApiConstants.connectTimeout);
      expect(client.dio.options.receiveTimeout, ApiConstants.receiveTimeout);
      expect(client.dio.options.sendTimeout, ApiConstants.sendTimeout);
    });

    test('sets JSON content and response types', () {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      expect(client.dio.options.responseType, ResponseType.json);
      expect(client.dio.options.contentType, Headers.jsonContentType);
    });
  });

  group('DioClient auth', () {
    test('adds Basic Authorization header when credentials provided', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        username: 'user',
        password: 'pass',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      RequestOptions? captured;
      client.dio.httpClientAdapter = _Adapter((options) {
        captured = options;
        return _jsonResponse(options);
      });

      await client.dio.get<dynamic>('/health');

      final expected = 'Basic ${base64Encode(utf8.encode('user:pass'))}';
      expect(captured?.headers['authorization'], expected);
    });

    test('omits Authorization header when credentials absent', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      RequestOptions? captured;
      client.dio.httpClientAdapter = _Adapter((options) {
        captured = options;
        return _jsonResponse(options);
      });

      await client.dio.get<dynamic>('/health');

      expect(captured?.headers.containsKey('authorization'), isFalse);
    });

    test('updateCredentials changes the Authorization header', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      client.updateCredentials(username: 'alice', password: 'secret');
      RequestOptions? first;
      client.dio.httpClientAdapter = _Adapter((options) {
        first = options;
        return _jsonResponse(options);
      });
      await client.dio.get<dynamic>('/a');
      expect(
        first?.headers['authorization'],
        'Basic ${base64Encode(utf8.encode('alice:secret'))}',
      );

      client.updateCredentials(username: 'bob', password: 'other');
      RequestOptions? second;
      client.dio.httpClientAdapter = _Adapter((options) {
        second = options;
        return _jsonResponse(options);
      });
      await client.dio.get<dynamic>('/b');
      expect(
        second?.headers['authorization'],
        'Basic ${base64Encode(utf8.encode('bob:other'))}',
      );
    });

    test('updateCredentials(null) clears Authorization header', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        username: 'user',
        password: 'pass',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      client.updateCredentials();
      RequestOptions? captured;
      client.dio.httpClientAdapter = _Adapter((options) {
        captured = options;
        return _jsonResponse(options);
      });
      await client.dio.get<dynamic>('/health');

      expect(captured?.headers.containsKey('authorization'), isFalse);
    });

    test(
      'updateCredentials with empty strings clears Authorization header',
      () async {
        final client = DioClient(
          baseUrl: 'http://example.com',
          username: 'user',
          password: 'pass',
          enableLogging: false,
        );
        addTearDown(client.dispose);

        client.updateCredentials(username: '', password: '');
        RequestOptions? captured;
        client.dio.httpClientAdapter = _Adapter((options) {
          captured = options;
          return _jsonResponse(options);
        });
        await client.dio.get<dynamic>('/health');

        expect(captured?.headers.containsKey('authorization'), isFalse);
      },
    );
  });

  group('DioClient errors', () {
    test('maps 401 to AuthException', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);
      client.dio.httpClientAdapter = _Adapter(
        (options) => _statusResponse(options, 401),
      );

      try {
        await client.dio.get<dynamic>('/secure');
        fail('expected DioException');
      } on DioException catch (e) {
        expect(e.error, isA<AuthException>());
        expect((e.error! as AuthException).statusCode, 401);
      }
    });

    test('maps 500 to ServerException', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);
      client.dio.httpClientAdapter = _Adapter(
        (options) => _statusResponse(options, 500),
      );

      try {
        await client.dio.get<dynamic>('/boom');
        fail('expected DioException');
      } on DioException catch (e) {
        expect(e.error, isA<ServerException>());
        expect((e.error! as ServerException).statusCode, 500);
      }
    });

    test('maps connect timeout to TimeoutException', () async {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(client.dispose);
      client.dio.httpClientAdapter = _Adapter((options) {
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.connectionTimeout,
        );
      });

      try {
        await client.dio.get<dynamic>('/slow');
        fail('expected DioException');
      } on DioException catch (e) {
        expect(e.error, isA<TimeoutException>());
      }
    });
  });

  group('DioClient updateBaseUrl', () {
    test('subsequent requests hit the new base URL', () async {
      final client = DioClient(
        baseUrl: 'http://old.example',
        enableLogging: false,
      );
      addTearDown(client.dispose);

      client.updateBaseUrl('http://new.example');
      RequestOptions? captured;
      client.dio.httpClientAdapter = _Adapter((options) {
        captured = options;
        return _jsonResponse(options);
      });

      await client.dio.get<dynamic>('/health');

      expect(captured?.baseUrl, 'http://new.example');
      expect(captured?.uri.toString(), 'http://new.example/health');
    });
  });

  group('DioClient logging', () {
    test('adds logging interceptor when enableLogging is true', () {
      final withLogging = DioClient(baseUrl: 'http://example.com');
      final withoutLogging = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(withLogging.dispose);
      addTearDown(withoutLogging.dispose);

      expect(
        withLogging.dio.interceptors.length,
        withoutLogging.dio.interceptors.length + 1,
      );
    });

    test('omits logging interceptor when enableLogging is false', () {
      final withLogging = DioClient(baseUrl: 'http://example.com');
      final withoutLogging = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      addTearDown(withLogging.dispose);
      addTearDown(withoutLogging.dispose);

      expect(
        withoutLogging.dio.interceptors.length,
        withLogging.dio.interceptors.length - 1,
      );
    });
  });

  group('DioClient dispose', () {
    test('closes Dio and is idempotent', () {
      final client = DioClient(
        baseUrl: 'http://example.com',
        enableLogging: false,
      );
      client.dispose();
      client.dispose();
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

Future<ResponseBody> _jsonResponse(RequestOptions options) async {
  return ResponseBody.fromString(
    '{"ok":true}',
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

Future<ResponseBody> _statusResponse(RequestOptions options, int status) async {
  return ResponseBody.fromString(
    '{"error":true}',
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}
