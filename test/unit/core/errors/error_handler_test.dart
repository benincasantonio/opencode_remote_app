import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/error_handler.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';

void main() {
  final requestOptions = RequestOptions();

  group('ErrorHandler.mapDioException', () {
    group('timeouts', () {
      test('connectionTimeout maps to TimeoutException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
          error: null,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<TimeoutException>());
        expect(result.message, 'Connection timed out');
      });

      test('sendTimeout maps to TimeoutException', () {
        final dioError = DioException(
          requestOptions: requestOptions.copyWith(
            sendTimeout: const Duration(seconds: 5),
          ),
          type: DioExceptionType.sendTimeout,
          error: null,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<TimeoutException>());
        expect(result.message, 'Send timed out');
        final timeout = result as TimeoutException;
        expect(timeout.duration, const Duration(seconds: 5));
      });

      test('receiveTimeout maps to TimeoutException', () {
        final dioError = DioException(
          requestOptions: requestOptions.copyWith(
            receiveTimeout: const Duration(seconds: 30),
          ),
          type: DioExceptionType.receiveTimeout,
          error: null,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<TimeoutException>());
        expect(result.message, 'Receive timed out');
        final timeout = result as TimeoutException;
        expect(timeout.duration, const Duration(seconds: 30));
      });
    });

    group('badResponse', () {
      test('401 maps to AuthException', () {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 401,
        );
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: response,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<AuthException>());
        expect(result.message, 'Unauthorized');
        final auth = result as AuthException;
        expect(auth.statusCode, 401);
      });

      test('403 maps to AuthException', () {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 403,
        );
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: response,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<AuthException>());
        expect(result.message, 'Forbidden');
        final auth = result as AuthException;
        expect(auth.statusCode, 403);
      });

      test('404 maps to ServerException', () {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 404,
          data: {'error': 'not found'},
        );
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: response,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<ServerException>());
        expect(result.message, 'Resource not found');
        final server = result as ServerException;
        expect(server.statusCode, 404);
        expect(server.responseBody, isNotNull);
      });

      test('500 maps to ServerException', () {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 500,
          data: 'Internal Server Error',
        );
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: response,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<ServerException>());
        expect(result.message, 'Server error 500');
        final server = result as ServerException;
        expect(server.statusCode, 500);
        expect(server.responseBody, 'Internal Server Error');
      });

      test('null response maps to ServerException with statusCode 0', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: null,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<ServerException>());
        final server = result as ServerException;
        expect(server.statusCode, 0);
      });
    });

    group('network', () {
      test('connectionError maps to NetworkException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
          message: 'Failed host lookup',
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<NetworkException>());
        expect(result.message, contains('Connection failed'));
      });

      test('cancel maps to NetworkException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.cancel,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<NetworkException>());
        expect(result.message, 'Request was cancelled');
      });

      test('badCertificate maps to NetworkException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badCertificate,
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<NetworkException>());
        expect(result.message, 'Invalid SSL certificate');
      });
    });

    group('unknown', () {
      test(
        'SocketException maps to NetworkException with no internet message',
        () {
          final socketError = SocketException('Connection refused');
          final dioError = DioException(
            requestOptions: requestOptions,
            type: DioExceptionType.unknown,
            error: socketError,
          );

          final result = ErrorHandler.mapDioException(dioError);

          expect(result, isA<NetworkException>());
          expect(result.message, 'No internet connection');
        },
      );

      test('other unknown errors map to NetworkException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
          message: 'Unknown error',
          error: Exception('some error'),
        );

        final result = ErrorHandler.mapDioException(dioError);

        expect(result, isA<NetworkException>());
        expect(result.message, contains('unexpected'));
      });
    });
  });

  group('ErrorHandler.mapCacheException', () {
    test('maps error string to CacheException', () {
      final result = ErrorHandler.mapCacheException('read failed');

      expect(result, isA<CacheException>());
      expect(result.message, 'Cache error: read failed');
    });

    test('maps Exception object to CacheException', () {
      final exception = Exception('disk full');
      final result = ErrorHandler.mapCacheException(exception);

      expect(result, isA<CacheException>());
      expect(result.message, contains('Cache error'));
      expect(result.message, contains('disk full'));
    });

    test('includes stackTrace when provided', () {
      final trace = StackTrace.current;
      final result = ErrorHandler.mapCacheException('error', trace);

      expect(result.stackTrace, trace);
    });
  });

  group('ErrorHandler.handle', () {
    test('delegates DioException to mapDioException', () {
      final dioError = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      );

      final result = ErrorHandler.handle(dioError, StackTrace.current);

      expect(result, isA<TimeoutException>());
    });

    test('passes through existing AppException', () {
      const auth = AuthException('forbidden', statusCode: 403);

      final result = ErrorHandler.handle(auth, StackTrace.current);

      expect(result, same(auth));
    });

    test('wraps arbitrary Object in NetworkException', () {
      final error = 'some string error';

      final result = ErrorHandler.handle(error, StackTrace.current);

      expect(result, isA<NetworkException>());
      expect(result.message, contains('unexpected'));
      expect(result.message, contains('some string error'));
    });

    test('preserves StackTrace for wrapped errors', () {
      final trace = StackTrace.current;
      final error = Exception('test');

      final result = ErrorHandler.handle(error, trace);

      expect(result.stackTrace, trace);
    });
  });
}
