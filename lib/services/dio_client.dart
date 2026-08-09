import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core/constants/api_constants.dart';
import '../core/errors/error_handler.dart';
import '../core/utils/logger.dart';

const _authorizationHeader = 'authorization';

/// Configured [Dio] HTTP client for the OpenCode server.
///
/// Owns base URL, optional Basic auth credentials, logging, and error mapping
/// to [AppException] via [ErrorHandler.mapDioException].
class DioClient {
  DioClient({
    required String baseUrl,
    String? username,
    String? password,
    bool enableLogging = kDebugMode,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: ApiConstants.connectTimeout,
           receiveTimeout: ApiConstants.receiveTimeout,
           sendTimeout: ApiConstants.sendTimeout,
           responseType: ResponseType.json,
           contentType: Headers.jsonContentType,
         ),
       ),
       _authInterceptor = _AuthInterceptor() {
    if (enableLogging) {
      _dio.interceptors.add(const _LoggingInterceptor());
    }
    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(const _ErrorMappingInterceptor());

    updateCredentials(username: username, password: password);
  }

  final Dio _dio;
  final _AuthInterceptor _authInterceptor;
  bool _disposed = false;

  /// Underlying Dio instance for repositories / datasources.
  Dio get dio => _dio;

  /// Updates [BaseOptions.baseUrl]. In-flight requests keep their original URL.
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Sets or clears Basic auth credentials.
  ///
  /// [username] / [password] of `null` or empty string clear the auth header.
  void updateCredentials({String? username, String? password}) {
    _authInterceptor.updateCredentials(username: username, password: password);
  }

  /// Closes the underlying Dio instance. Safe to call more than once.
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _dio.close(force: true);
  }
}

class _LoggingInterceptor extends Interceptor {
  const _LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.debug(
      'HTTP ${options.method} ${options.uri}',
      context: {'headers': _redactHeaders(options.headers)},
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    Logger.debug('HTTP ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error(
      'HTTP error ${err.requestOptions.method} ${err.requestOptions.uri}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }

  static Map<String, Object?> _redactHeaders(Map<String, dynamic> headers) {
    return headers.map((key, value) {
      if (key.toLowerCase() == _authorizationHeader) {
        return MapEntry(key, '<redacted>');
      }
      return MapEntry(key, value);
    });
  }
}

class _AuthInterceptor extends Interceptor {
  String? _username;
  String? _password;

  void updateCredentials({String? username, String? password}) {
    _username = _normalize(username);
    _password = _normalize(password);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_username == null && _password == null) {
      options.headers.remove(_authorizationHeader);
    } else {
      final token = base64Encode(
        utf8.encode('${_username ?? ''}:${_password ?? ''}'),
      );
      options.headers[_authorizationHeader] = 'Basic $token';
    }
    handler.next(options);
  }

  static String? _normalize(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }
}

class _ErrorMappingInterceptor extends Interceptor {
  const _ErrorMappingInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = ErrorHandler.mapDioException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        stackTrace: err.stackTrace,
        message: appException.message,
      ),
    );
  }
}
