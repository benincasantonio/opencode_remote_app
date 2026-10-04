import 'package:dio/dio.dart';

import '../datasources/agent_datasource.dart';
import '../models/agent_info.dart';

class AgentRepository {
  AgentRepository(this._datasource);

  final AgentDatasource _datasource;

  Future<List<AgentInfo>> getAgents({CancelToken? cancelToken}) =>
      _datasource.getAgents(cancelToken: cancelToken);
}
