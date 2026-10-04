import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../models/agent_info.dart';

class AgentDatasource {
  AgentDatasource(this._dio);

  final Dio _dio;

  Future<List<AgentInfo>> getAgents({CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        ApiConstants.agentPath,
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data == null) {
        throw const ParseException('Empty agent list response');
      }
      return data
          .map((item) => AgentInfo.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      final mapped = error.error;
      if (mapped is AppException) throw mapped;
      if (mapped is TypeError || mapped is FormatException) {
        throw ParseException(
          'Failed to parse agent list response: $mapped',
          stackTrace: error.stackTrace,
        );
      }
      rethrow;
    } on AppException {
      rethrow;
    } on Object catch (error, st) {
      throw ParseException(
        'Failed to parse agent list response: $error',
        stackTrace: st,
      );
    }
  }
}
