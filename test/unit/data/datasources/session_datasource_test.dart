import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/api_constants.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/session_datasource.dart';
import 'package:opencode_remote_app/data/models/session.dart';

void main() {
  group('SessionDatasource.getSessions', () {
    const sampleListJson = '''
[
  {
    "id": "ses_1",
    "slug": "quick-canyon",
    "projectID": "global",
    "directory": "/Users/developer",
    "title": "Fix bug",
    "version": "1.0.0",
    "time": {
      "created": 1000,
      "updated": 2000
    }
  }
]
''';

    test('parses a successful session list response', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.path, ApiConstants.sessionPath);
        return _jsonResponse(options, sampleListJson);
      });

      final sessions = await SessionDatasource(dio).getSessions();

      expect(sessions, hasLength(1));
      expect(sessions.first.id, 'ses_1');
      expect(sessions.first.slug, 'quick-canyon');
      expect(sessions.first.title, 'Fix bug');
      expect(sessions.first.time.created, 1000);
      expect(sessions.first.time.updated, 2000);
    });

    test('forwards query parameters correctly', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.queryParameters, {
          'directory': '/test/dir',
          'roots': 'true',
          'limit': 10,
        });
        return _jsonResponse(options, sampleListJson);
      });

      final sessions = await SessionDatasource(
        dio,
      ).getSessions(directory: '/test/dir', roots: 'true', limit: 10);

      expect(sessions, hasLength(1));
    });

    test('forwards the exact optional CancelToken to Dio', () async {
      final token = CancelToken();
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(identical(options.cancelToken, token), isTrue);
        return _jsonResponse(options, sampleListJson);
      });

      final sessions = await SessionDatasource(
        dio,
      ).getSessions(cancelToken: token);

      expect(sessions, hasLength(1));
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
        () => SessionDatasource(dio).getSessions(),
        throwsA(isA<AuthException>()),
      );
    });

    test('throws ParseException for invalid JSON shape', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        return _jsonResponse(options, '{"not_a_list": true}');
      });

      expect(
        () => SessionDatasource(dio).getSessions(),
        throwsA(isA<ParseException>()),
      );
    });
  });

  group('SessionDatasource.getSessionStatus', () {
    const sampleStatusJson = '''
{
  "ses_1": {
    "type": "idle"
  },
  "ses_2": {
    "type": "busy"
  },
  "ses_3": {
    "type": "retry",
    "attempt": 2,
    "message": "Quota exceeded",
    "next": 5000
  }
}
''';

    test('parses a successful session status response', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.path, ApiConstants.sessionStatusPath);
        return _jsonResponse(options, sampleStatusJson);
      });

      final statuses = await SessionDatasource(dio).getSessionStatus();

      expect(statuses, hasLength(3));
      expect(statuses['ses_1'], const SessionStatus.idle());
      expect(statuses['ses_2'], const SessionStatus.busy());
      expect(
        statuses['ses_3'],
        const SessionStatus.retry(
          attempt: 2,
          message: 'Quota exceeded',
          next: 5000,
        ),
      );
    });

    test('handles empty status response as empty map', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        return _jsonResponse(options, '{}');
      });

      final statuses = await SessionDatasource(dio).getSessionStatus();
      expect(statuses, isEmpty);
    });

    test('forwards query parameters correctly', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.queryParameters, {
          'directory': '/test/dir',
          'workspace': 'ws_1',
        });
        return _jsonResponse(options, '{}');
      });

      final statuses = await SessionDatasource(
        dio,
      ).getSessionStatus(directory: '/test/dir', workspace: 'ws_1');
      expect(statuses, isEmpty);
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
                error: const ServerException('Server error', statusCode: 500),
                response: error.response,
              ),
            );
          },
        ),
      );
      dio.httpClientAdapter = _Adapter((options) async {
        return ResponseBody.fromString(
          '{"error":true}',
          500,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      expect(
        () => SessionDatasource(dio).getSessionStatus(),
        throwsA(isA<ServerException>()),
      );
    });

    test('throws ParseException for invalid status JSON', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        return _jsonResponse(options, '["not_a_map"]');
      });

      expect(
        () => SessionDatasource(dio).getSessionStatus(),
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
