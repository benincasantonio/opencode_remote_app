import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/models/agent_info.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';

enum AgentPreviewState { ready, loading, error, empty }

enum CreationPreviewState { success, loading, error }

class PreviewSessionDeletion extends SessionDeletion {
  PreviewSessionDeletion(this.result);
  final CreationPreviewState result;

  @override
  Future<bool?> delete() async {
    state = const AsyncLoading();
    if (result == CreationPreviewState.loading) return null;
    final success = result == CreationPreviewState.success;
    state = success
        ? const AsyncData(true)
        : AsyncError(const NetworkException('Preview error'), StackTrace.empty);
    return success;
  }
}

FutureOr<List<AgentInfo>> previewAgents(AgentPreviewState state) =>
    switch (state) {
      AgentPreviewState.ready => const [
        AgentInfo(name: 'build', mode: 'primary'),
        AgentInfo(name: 'plan', mode: 'primary'),
      ],
      AgentPreviewState.loading => Completer<List<AgentInfo>>().future,
      AgentPreviewState.error => throw const NetworkException('Preview error'),
      AgentPreviewState.empty => const [],
    };

class PreviewSessionCreation extends SessionCreation {
  PreviewSessionCreation(this.result);

  final CreationPreviewState result;

  @override
  Future<Session?> create(CreateSessionInput input) async {
    if (state.isLoading) return null;
    final requestRef = ref;
    state = const AsyncLoading();
    if (result == CreationPreviewState.loading) return null;
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!requestRef.mounted) return null;
    if (result == CreationPreviewState.error) {
      state = AsyncError(
        const NetworkException('Preview error'),
        StackTrace.empty,
      );
      return null;
    }
    final session = Session(
      id: 'preview',
      slug: 'preview',
      projectID: 'global',
      directory: '/project',
      title: input.title ?? 'New session',
      agent: input.agent,
      version: '1.0',
      time: const SessionTime(created: 0, updated: 0),
    );
    state = AsyncData(session);
    return session;
  }
}
