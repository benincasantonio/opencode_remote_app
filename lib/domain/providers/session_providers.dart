import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/session_datasource.dart';
import '../../data/models/session.dart';
import '../../data/repositories/session_repository.dart';
import 'dio_providers.dart';

part 'session_providers.g.dart';

@Riverpod(keepAlive: true)
SessionDatasource sessionDatasource(Ref ref) {
  final client = ref.watch(dioClientProvider);
  return SessionDatasource(client.dio);
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

/// Fetches the map of session statuses from the server.
@riverpod
Future<Map<String, SessionStatus>> sessionStatuses(Ref ref) async {
  final repository = ref.watch(sessionRepositoryProvider);
  return repository.getSessionStatus();
}
