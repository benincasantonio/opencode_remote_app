import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/agent_datasource.dart';
import '../../data/models/agent_info.dart';
import '../../data/repositories/agent_repository.dart';
import 'connection_providers.dart';
import 'dio_providers.dart';

part 'agent_providers.g.dart';

@riverpod
AgentDatasource agentDatasource(Ref ref) =>
    AgentDatasource(ref.watch(dioClientProvider).dio);

@riverpod
AgentRepository agentRepository(Ref ref) =>
    AgentRepository(ref.watch(agentDatasourceProvider));

/// Only visible agents that can run a primary session are selectable.
@riverpod
Future<List<AgentInfo>> sessionAgents(Ref ref) async {
  ref.watch(
    connectionProvider.select((value) => (value.isConnected, value.baseUrl)),
  );
  final token = CancelToken();
  ref.onDispose(token.cancel);
  final agents = await ref
      .watch(agentRepositoryProvider)
      .getAgents(cancelToken: token);
  return agents
      .where(
        (agent) =>
            !agent.hidden && (agent.mode == 'primary' || agent.mode == 'all'),
      )
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}
