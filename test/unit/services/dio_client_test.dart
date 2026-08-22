import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:opencode_remote_app/core/constants/api_constants.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/services/dio_client.dart';

@GenerateMocks([HttpClientAdapter])
import 'dio_client_test.mocks.dart';

Future<RequestOptions> captureRequest(
  MockHttpClientAdapter mockAdapter,
  DioClient testClient,
) async {
  final captured = <RequestOptions>[];
  when(mockAdapter.fetch(any, any, any)).thenAnswer((invocation) {
    final request = invocation.positionalArguments[0] as RequestOptions;
    captured.add(request);
    final response = ResponseBody.fromString('OK', 200);
    return Future.value(response);
  });

  await testClient.dio.get('/test');

  return captured.first;
}

void main() {
  late MockHttpClientAdapter mockAdapter;
  late DioClient client;

  setUp(() {
    mockAdapter = MockHttpClientAdapter();
    client = DioClient(baseUrl: 'http://test.local:8080');
    client.dio.httpClientAdapter = mockAdapter;
  });

  tearDown(() {
    client.dispose();
  });

  group('construction', () {
    test('configures baseUrl from constructor', () {
      final testClient = DioClient(baseUrl: 'http://example.com:3000');

      expect(testClient.dio.options.baseUrl, 'http://example.com:3000');

      testClient.dispose();
    });

    test('applies ApiConstants timeouts', () {
      expect(client.dio.options.connectTimeout, ApiConstants.connectTimeout);
      expect(client.dio.options.receiveTimeout, ApiConstants.receiveTimeout);
      expect(client.dio.options.sendTimeout, ApiConstants.sendTimeout);
    });

    test('sets JSON content type and response type', () {
      expect(client.dio.options.contentType, Headers.jsonContentType);
      expect(client.dio.options.responseType, ResponseType.json);
    });
  });

  group('auth interceptor', () {
    test('attaches Basic auth header when credentials provided', () async {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        username: 'user',
        password: 'pass',
        enableLogging: false,
      );

      final mockAdapter2 = MockHttpClientAdapter();
      testClient.dio.httpClientAdapter = mockAdapter2;

      final response = ResponseBody.fromString('OK', 200);
      when(mockAdapter2.fetch(any, any, any)).thenAnswer((_) async => response);

      final capturedRequest = await captureRequest(mockAdapter2, testClient);

      final expectedAuth = base64.encode(utf8.encode('user:pass'));
      expect(capturedRequest.headers['Authorization'], 'Basic $expectedAuth');

      testClient.dispose();
    });

    test('omits auth header when no credentials', () async {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        enableLogging: false,
      );

      final mockAdapter2 = MockHttpClientAdapter();
      testClient.dio.httpClientAdapter = mockAdapter2;

      final response = ResponseBody.fromString('OK', 200);
      when(mockAdapter2.fetch(any, any, any)).thenAnswer((_) async => response);

      final capturedRequest = await captureRequest(mockAdapter2, testClient);

      expect(capturedRequest.headers['Authorization'], isNull);

      testClient.dispose();
    });

    test('updateCredentials changes header on subsequent requests', () async {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        username: 'user1',
        password: 'pass1',
        enableLogging: false,
      );

      testClient.updateCredentials(username: 'user2', password: 'pass2');

      final mockAdapter2 = MockHttpClientAdapter();
      testClient.dio.httpClientAdapter = mockAdapter2;

      final response = ResponseBody.fromString('OK', 200);
      when(mockAdapter2.fetch(any, any, any)).thenAnswer((_) async => response);

      final capturedRequest = await captureRequest(mockAdapter2, testClient);

      final expectedAuth = base64.encode(utf8.encode('user2:pass2'));
      expect(capturedRequest.headers['Authorization'], 'Basic $expectedAuth');

      testClient.dispose();
    });

    test('updateCredentials with null clears auth', () async {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        username: 'user',
        password: 'pass',
        enableLogging: false,
      );

      testClient.updateCredentials(username: null, password: null);

      final mockAdapter2 = MockHttpClientAdapter();
      testClient.dio.httpClientAdapter = mockAdapter2;

      final response = ResponseBody.fromString('OK', 200);
      when(mockAdapter2.fetch(any, any, any)).thenAnswer((_) async => response);

      final capturedRequest = await captureRequest(mockAdapter2, testClient);

      expect(capturedRequest.headers['Authorization'], isNull);

      testClient.dispose();
    });

    test('updateCredentials with empty strings clears auth', () async {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        username: 'user',
        password: 'pass',
        enableLogging: false,
      );

      testClient.updateCredentials(username: '', password: '');

      final mockAdapter2 = MockHttpClientAdapter();
      testClient.dio.httpClientAdapter = mockAdapter2;

      final response = ResponseBody.fromString('OK', 200);
      when(mockAdapter2.fetch(any, any, any)).thenAnswer((_) async => response);

      final capturedRequest = await captureRequest(mockAdapter2, testClient);

      expect(capturedRequest.headers['Authorization'], isNull);

      testClient.dispose();
    });
  });

  group('error mapping', () {
    test('maps 401 to AuthException', () async {
      final response = ResponseBody.fromString(
        '{"error": "Unauthorized"}',
        401,
        statusMessage: 'Unauthorized',
      );

      when(mockAdapter.fetch(any, any, any)).thenAnswer((_) async => response);

      try {
        await client.dio.get('/test');
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<DioException>());
        final dioError = e as DioException;
        expect(dioError.error, isA<AuthException>());
        final authException = dioError.error as AuthException;
        expect(authException.statusCode, 401);
      }
    });

    test('maps 500 to ServerException', () async {
      final response = ResponseBody.fromString(
        'Internal Server Error',
        500,
        statusMessage: 'Internal Server Error',
      );

      when(mockAdapter.fetch(any, any, any)).thenAnswer((_) async => response);

      try {
        await client.dio.get('/test');
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<DioException>());
        final dioError = e as DioException;
        expect(dioError.error, isA<ServerException>());
        final serverException = dioError.error as ServerException;
        expect(serverException.statusCode, 500);
        expect(serverException.responseBody, 'Internal Server Error');
      }
    });

    test('maps connection timeout to TimeoutException', () async {
      when(mockAdapter.fetch(any, any, any)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      try {
        await client.dio.get('/test');
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<DioException>());
        final dioError = e as DioException;
        expect(dioError.error, isA<TimeoutException>());
        final timeoutException = dioError.error as TimeoutException;
        expect(timeoutException.message, 'Connection timed out');
      }
    });
  });

  group('updateBaseUrl', () {
    test('changes base URL for subsequent requests', () {
      client.updateBaseUrl('http://new-host.local:9000');

      expect(client.dio.options.baseUrl, 'http://new-host.local:9000');
    });
  });

  group('logging', () {
    test('interceptor added when enableLogging=true', () {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        enableLogging: true,
      );

      expect(testClient.dio.interceptors.length, 4);

      testClient.dispose();
    });

    test('interceptor not added when enableLogging=false', () {
      final testClient = DioClient(
        baseUrl: 'http://test.local',
        enableLogging: false,
      );

      expect(testClient.dio.interceptors.length, 3);

      testClient.dispose();
    });
  });

  group('dispose', () {
    test('closes the Dio instance', () {
      final testClient = DioClient(baseUrl: 'http://test.local');

      expect(() => testClient.dispose(), returnsNormally);
      expect(() => testClient.dispose(), returnsNormally);
    });
  });
}
