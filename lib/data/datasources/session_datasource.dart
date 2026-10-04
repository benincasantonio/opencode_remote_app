import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../models/session.dart';

/// HTTP datasource for OpenCode session endpoints.
class SessionDatasource {
  SessionDatasource(this._dio);

  final Dio _dio;

  Future<void> deleteSession(String id, {CancelToken? cancelToken}) =>
      _request(() async {
        final response = await _dio.delete<bool>(
          '${ApiConstants.sessionPath}/${Uri.encodeComponent(id)}',
          cancelToken: cancelToken,
        );
        if (response.data != true) {
          throw const ParseException('Session deletion was not confirmed');
        }
      });

  /// POST [/session](ApiConstants.sessionPath).
  Future<Session> createSession(
    CreateSessionInput input, {
    CancelToken? cancelToken,
  }) => _request(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.sessionPath,
      data: input.toJson(),
      cancelToken: cancelToken,
    );
    final data = response.data;
    if (data == null) {
      throw const ParseException('Empty session creation response');
    }
    return Session.fromJson(data);
  });

  /// GET [/session](ApiConstants.sessionPath).
  Future<List<Session>> getSessions({
    String? directory,
    String? roots,
    int? limit,
    CancelToken? cancelToken,
  }) => _request(() async {
    final queryParams = <String, dynamic>{
      'directory': ?directory,
      'roots': ?roots,
      'limit': ?limit,
    };

    final response = await _dio.get<List<dynamic>>(
      ApiConstants.sessionPath,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null) {
      throw const ParseException('Empty session list response');
    }

    return data
        .map((item) => Session.fromJson(item as Map<String, dynamic>))
        .toList();
  });

  /// GET [/session/status](ApiConstants.sessionStatusPath).
  Future<Map<String, SessionStatus>> getSessionStatus({
    String? directory,
    String? workspace,
    CancelToken? cancelToken,
  }) => _request(() async {
    final queryParams = <String, dynamic>{
      'directory': ?directory,
      'workspace': ?workspace,
    };

    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.sessionStatusPath,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null) {
      throw const ParseException('Empty session status response');
    }

    final result = <String, SessionStatus>{};
    for (final entry in data.entries) {
      final value = entry.value;
      if (value is Map<String, dynamic>) {
        result[entry.key] = SessionStatus.fromJson(value);
      }
    }
    return result;
  });

  Future<T> _request<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      final mapped = error.error;
      if (mapped is AppException) throw mapped;
      if (mapped is TypeError || mapped is FormatException) {
        throw ParseException(
          'Failed to parse session response: $mapped',
          stackTrace: error.stackTrace,
        );
      }
      rethrow;
    } on AppException {
      rethrow;
    } on Object catch (error, st) {
      throw ParseException(
        'Failed to parse session response: $error',
        stackTrace: st,
      );
    }
  }
}
