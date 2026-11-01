import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/api_constants.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/message_datasource.dart';
import 'package:opencode_remote_app/data/models/message.dart';

void main() {
  final fixture = File(
    'test/unit/data/models/fixtures/messages_page.json',
  ).readAsStringSync();

  group('MessageDatasource.getMessages', () {
    test('parses the messages fixture oldest-first', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.path, ApiConstants.messagePath('ses_1'));
        expect(options.queryParameters, isEmpty);
        return _jsonResponse(
          options,
          fixture,
          headers: {
            'x-next-cursor': ['cursor-1'],
          },
        );
      });

      final page = await MessageDatasource(dio).getMessages('ses_1');

      expect(page.nextCursor, 'cursor-1');
      expect(page.messages, hasLength(2));
      expect(page.messages.first.info.id, 'msg_dd7f9fad4001r0us5UB3S97qmT');
      expect(
        page.messages.last.info,
        isA<AssistantMessage>().having(
          (message) => message.error?.message,
          'error.message',
          'Aborted',
        ),
      );
    });

    test('forwards limit, before, and the cancel token', () async {
      final token = CancelToken();
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        expect(options.path, '/session/ses%201/message');
        expect(options.queryParameters, {'limit': 50, 'before': 'msg_old'});
        expect(identical(options.cancelToken, token), isTrue);
        return _jsonResponse(options, '[]');
      });

      final page = await MessageDatasource(
        dio,
      ).getMessages('ses 1', limit: 50, before: 'msg_old', cancelToken: token);

      expect(page.messages, isEmpty);
      expect(page.nextCursor, isNull);
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
        () => MessageDatasource(dio).getMessages('ses_1'),
        throwsA(isA<AuthException>()),
      );
    });

    test('throws ParseException for an empty body', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        return ResponseBody.fromString(
          '',
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      expect(
        () => MessageDatasource(dio).getMessages('ses_1'),
        throwsA(isA<ParseException>()),
      );
    });

    test('throws ParseException for a JSON null body', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://example.com'));
      dio.httpClientAdapter = _Adapter((options) async {
        return _jsonResponse(options, 'null');
      });

      expect(
        () => MessageDatasource(dio).getMessages('ses_1'),
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

Future<ResponseBody> _jsonResponse(
  RequestOptions options,
  String body, {
  Map<String, List<String>> headers = const {},
}) async {
  return ResponseBody.fromString(
    body,
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
      ...headers,
    },
  );
}
