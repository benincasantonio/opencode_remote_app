import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';

/// Centralized error mapping utility for the OpenCode Remote app.
///
/// Converts low-level exceptions (DioException, platform storage errors, etc.)
/// into the app's sealed [AppException] hierarchy for consistent handling
/// across repositories and UI layers.
class ErrorHandler {
  ErrorHandler._();

  /// Maps [DioException] variants to the appropriate [AppException] subclass.
  ///
  /// Handles all [DioExceptionType] values:
  /// - Timeouts → [TimeoutException]
  /// - 401/403 → [AuthException]
  /// - 4xx/5xx → [ServerException]
  /// - Connection/certificate/cancel → [NetworkException]
  /// - SocketException in unknown → [NetworkException] with "No internet" message
  static AppException mapDioException(DioException error) {
    final stackTrace = error.stackTrace;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutException(
          'Connection timed out',
          stackTrace: stackTrace,
          duration: error.requestOptions.connectTimeout,
        );

      case DioExceptionType.sendTimeout:
        return TimeoutException(
          'Send timed out',
          stackTrace: stackTrace,
          duration: error.requestOptions.sendTimeout,
        );

      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          'Receive timed out',
          stackTrace: stackTrace,
          duration: error.requestOptions.receiveTimeout,
        );

      case DioExceptionType.badResponse:
        return _mapBadResponse(error);

      case DioExceptionType.connectionError:
        return NetworkException(
          'Connection failed: ${error.message ?? "Unknown connection error"}',
          stackTrace,
        );

      case DioExceptionType.cancel:
        return const NetworkException('Request was cancelled');

      case DioExceptionType.badCertificate:
        return const NetworkException('Invalid SSL certificate');

      case DioExceptionType.unknown:
        final innerError = error.error;
        if (innerError is SocketException) {
          return const NetworkException('No internet connection');
        }
        return NetworkException(
          'An unexpected network error occurred: ${error.message ?? error.error}',
          stackTrace,
        );
    }
  }

  /// Maps HTTP response errors from [DioException.badResponse] to [ServerException]
  /// or [AuthException] based on status code.
  static AppException _mapBadResponse(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode ?? 0;
    final responseBody = response?.data?.toString();
    final stackTrace = error.stackTrace;

    switch (statusCode) {
      case 401:
        return AuthException(
          'Unauthorized',
          statusCode: statusCode,
          stackTrace: stackTrace,
        );

      case 403:
        return AuthException(
          'Forbidden',
          statusCode: statusCode,
          stackTrace: stackTrace,
        );

      case 404:
        return ServerException(
          'Resource not found',
          statusCode: statusCode,
          responseBody: responseBody,
          stackTrace: stackTrace,
        );

      default:
        return ServerException(
          'Server error $statusCode',
          statusCode: statusCode,
          responseBody: responseBody,
          stackTrace: stackTrace,
        );
    }
  }

  /// Maps local-storage errors (from [SharedPreferences] or [FlutterSecureStorage])
  /// into [CacheException].
  static CacheException mapCacheException(
    Object error, [
    StackTrace? stackTrace,
  ]) {
    return CacheException('Cache error: $error', stackTrace);
  }

  /// Catch-all entry point for repository-level error handling.
  ///
  /// Delegates to the appropriate mapper or wraps unknown errors:
  /// - [DioException] → calls [mapDioException]
  /// - [AppException] → returns as-is
  /// - Anything else → wraps in [NetworkException]
  static AppException handle(Object error, StackTrace stackTrace) {
    if (error is DioException) {
      return mapDioException(error);
    }

    if (error is AppException) {
      return error;
    }

    return NetworkException('An unexpected error occurred: $error', stackTrace);
  }
}
