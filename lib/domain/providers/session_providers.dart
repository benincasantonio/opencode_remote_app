import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/session_datasource.dart';
import '../../data/models/session.dart';
import '../../data/repositories/session_repository.dart';
import 'connection_providers.dart';
import 'dio_providers.dart';

part 'session_providers.g.dart';

@Riverpod(keepAlive: true)
SessionDatasource sessionDatasource(Ref ref) {
  final client = ref.watch(dioClientProvider);
  return SessionDatasource(client.dio);
}

/// Independent state per row prevents repeated deletion requests.
@riverpod
class SessionDeletion extends _$SessionDeletion {
  @override
  FutureOr<bool> build(String sessionId) {
    ref.watch(
      connectionProvider.select((value) => (value.isConnected, value.baseUrl)),
    );
    return false;
  }

  Future<bool?> delete() async {
    if (state.isLoading || state.value == true) return null;
    final requestRef = ref;
    final token = CancelToken();
    requestRef.onDispose(token.cancel);
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await requestRef
          .read(sessionRepositoryProvider)
          .deleteSession(sessionId, cancelToken: token);
      return true;
    });
    if (!requestRef.mounted || token.isCancelled) return null;
    state = result;
    if (result.hasError) return false;
    requestRef.invalidate(sessionsListProvider);
    requestRef.invalidate(sessionStatusesProvider);
    return true;
  }
}

@Riverpod(keepAlive: true)
SessionRepository sessionRepository(Ref ref) {
  return SessionRepository(ref.watch(sessionDatasourceProvider));
}

/// Fetches all sessions from the server, defensively sorted by
/// [SessionTime.updated] descending (most recently updated first).
@riverpod
Future<List<Session>> sessionsList(Ref ref) async {
  final repository = ref.watch(sessionRepositoryProvider);
  final sessions = await repository.getSessions();
  final sorted = List<Session>.from(sessions)
    ..sort((a, b) => b.time.updated.compareTo(a.time.updated));
  return sorted;
}

/// Derives the dashboard preview from the same cache as the full list.
@riverpod
AsyncValue<List<Session>> recentSessions(Ref ref) => ref
    .watch(sessionsListProvider)
    .whenData((sessions) => sessions.take(5).toList());

/// Fetches the map of session statuses from the server.
@riverpod
Future<Map<String, SessionStatus>> sessionStatuses(Ref ref) async {
  final repository = ref.watch(sessionRepositoryProvider);
  return repository.getSessionStatus();
}

/// A dialog-scoped action. Rebuilding this provider never repeats a POST.
@riverpod
class SessionCreation extends _$SessionCreation {
  @override
  FutureOr<Session?> build() {
    ref.watch(
      connectionProvider.select((value) => (value.isConnected, value.baseUrl)),
    );
    return null;
  }

  Future<Session?> create(CreateSessionInput input) async {
    if (state.isLoading) return null;

    // Cancellation also marks requests from an earlier server as obsolete.
    final requestRef = ref;
    final token = CancelToken();
    requestRef.onDispose(token.cancel);
    state = const AsyncLoading();
    try {
      final session = await requestRef
          .read(sessionRepositoryProvider)
          .createSession(input, cancelToken: token);
      if (!requestRef.mounted || token.isCancelled) return null;
      requestRef.invalidate(sessionsListProvider);
      state = AsyncData(session);
      return session;
    } on Object catch (error, st) {
      if (requestRef.mounted && !token.isCancelled) {
        state = AsyncError(error, st);
      }
      return null;
    }
  }
}
