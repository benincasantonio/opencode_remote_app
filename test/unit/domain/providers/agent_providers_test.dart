import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/models/agent_info.dart';
import 'package:opencode_remote_app/data/repositories/agent_repository.dart';
import 'package:opencode_remote_app/domain/providers/agent_providers.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';

import '../../../support/session_test_support.dart';

class _AgentRepository implements AgentRepository {
  List<AgentInfo> agents = [];
  Object? error;
  Future<List<AgentInfo>>? pending;
  final tokens = <CancelToken?>[];

  @override
  Future<List<AgentInfo>> getAgents({CancelToken? cancelToken}) async {
    tokens.add(cancelToken);
    final failure = error;
    if (failure != null) throw failure;
    return pending ?? Future.value(agents);
  }
}

void main() {
  late _AgentRepository repository;
  late ProviderContainer container;
  setUp(() {
    repository = _AgentRepository();
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        agentRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });
  tearDown(() => container.dispose());

  test(
    'filters hidden, subagent and unknown modes, sorting without mutating source',
    () async {
      repository.agents = const [
        AgentInfo(name: 'plan', mode: 'primary'),
        AgentInfo(name: 'explore', mode: 'subagent'),
        AgentInfo(name: 'internal', mode: 'primary', hidden: true),
        AgentInfo(name: 'build', mode: 'all'),
        AgentInfo(name: 'future', mode: 'unknown'),
      ];
      container.listen(sessionAgentsProvider, (_, _) {});
      final result = await container.read(sessionAgentsProvider.future);
      expect(result.map((agent) => agent.name), ['build', 'plan']);
      expect(repository.agents.first.name, 'plan');
    },
  );

  test('failed load can be retried explicitly', () async {
    repository.error = const NetworkException('offline');
    container.listen(sessionAgentsProvider, (_, _) {});
    await expectLater(
      container.read(sessionAgentsProvider.future),
      throwsA(isA<NetworkException>()),
    );
    repository.error = null;
    repository.agents = const [AgentInfo(name: 'build', mode: 'primary')];
    container.invalidate(sessionAgentsProvider);
    expect(
      await container.read(sessionAgentsProvider.future),
      repository.agents,
    );
    expect(repository.tokens, hasLength(2));
  });

  test(
    'changing server cancels old lookup and keeps only the new result',
    () async {
      final pending = Completer<List<AgentInfo>>();
      repository.pending = pending.future;
      // Start the first request before changing the connection.
      container.listen(sessionAgentsProvider, (_, _) {});
      repository.pending = null;
      repository.agents = const [
        AgentInfo(name: 'new-server', mode: 'primary'),
      ];
      (container.read(connectionProvider.notifier) as TestConnection)
          .changeServer();
      await container.pump();
      expect(repository.tokens.first?.isCancelled, isTrue);
      expect(
        await container.read(sessionAgentsProvider.future),
        repository.agents,
      );
      pending.complete(const [AgentInfo(name: 'old-server', mode: 'primary')]);
      await container.pump();
      expect(container.read(sessionAgentsProvider).value, repository.agents);
    },
  );
}
