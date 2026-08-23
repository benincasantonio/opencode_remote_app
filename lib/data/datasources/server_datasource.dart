import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../models/server_health.dart';

/// HTTP datasource for OpenCode server endpoints used by Connect / Dashboard.
class ServerDatasource {
  ServerDatasource(this._dio);

  final Dio _dio;

  /// GET [/global/health](ApiConstants.healthPath).
  Future<ServerHealth> getHealth({CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.healthPath,
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data == null) {
        throw const ParseException('Empty health response');
      }
      return ServerHealth.fromJson(data);
    } on DioException catch (error) {
      final mapped = error.error;
      if (mapped is AppException) {
        throw mapped;
      }
      rethrow;
    } on AppException {
      rethrow;
    } on Object catch (error, st) {
      throw ParseException(
        'Failed to parse health response: $error',
        stackTrace: st,
      );
    }
  }
}
