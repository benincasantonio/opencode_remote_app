import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/error_handler.dart';
import '../../core/utils/logger.dart';

class DioClient {
  DioClient({
    required String baseUrl,
    String? username,
    String? password,
    bool enableLogging = kDebugMode,
  }) : _dio = Dio(_createBaseOptions(baseUrl)),
       _loggingInterceptor = enableLogging ? _LoggingInterceptor() : null,
       _authInterceptor = _AuthInterceptor() {
    if (_loggingInterceptor != null) {
      _dio.interceptors.add(_loggingInterceptor);
    }
    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(_ErrorMappingInterceptor());

    updateCredentials(username: username, password: password);
  }

  final Dio _dio;
  final _LoggingInterceptor? _loggingInterceptor;
  final _AuthInterceptor _authInterceptor;

  Dio get dio => _dio;

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  void updateCredentials({String? username, String? password}) {
    _authInterceptor.updateCredentials(
      username?.isEmpty ?? true ? null : username,
      password?.isEmpty ?? true ? null : password,
    );
  }

  void dispose() {
    _dio.close(force: true);
  }

  static BaseOptions _createBaseOptions(String baseUrl) {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final headers = Map<String, dynamic>.from(options.headers);

    if (headers.containsKey('Authorization')) {
      headers['Authorization'] = '<REDACTED>';
    }

    Logger.debug(
      '${options.method} ${options.uri}',
      context: {
        'method': options.method,
        'uri': options.uri.toString(),
        'headers': headers,
      },
    );

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.debug(
      '${response.statusCode} ${response.requestOptions.uri}',
      context: {
        'statusCode': response.statusCode,
        'uri': response.requestOptions.uri.toString(),
      },
    );

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.error(
      '${err.type} ${err.requestOptions.uri}',
      error: err.error,
      stackTrace: err.stackTrace,
      context: {
        'type': err.type.toString(),
        'uri': err.requestOptions.uri.toString(),
        'statusCode': err.response?.statusCode,
      },
    );

    handler.next(err);
  }
}

class _AuthInterceptor extends Interceptor {
  String? _encodedCredentials;

  void updateCredentials(String? username, String? password) {
    if (username != null && password != null) {
      final credentials = '$username:$password';
      _encodedCredentials = base64.encode(utf8.encode(credentials));
    } else {
      _encodedCredentials = null;
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_encodedCredentials != null) {
      options.headers['Authorization'] = 'Basic $_encodedCredentials';
    }

    handler.next(options);
  }
}

class _ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = ErrorHandler.mapDioException(err);
    final mappedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: appException,
      stackTrace: err.stackTrace,
    );

    handler.reject(mappedError);
  }
}
