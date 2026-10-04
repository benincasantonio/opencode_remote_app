import 'package:dio/dio.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/data/repositories/session_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

const testHealth = ServerHealth(healthy: true, version: '1.0');
const testConnection = AppConnectionState(
  status: ConnectionStatus.connected,
  baseUrl: 'http://example.com',
  health: testHealth,
);
const createdSession = Session(
  id: 'ses_new',
  slug: 'new-session',
  projectID: 'global',
  directory: '/project',
  title: 'New session title',
  version: '1.0',
  time: SessionTime(created: 5000, updated: 5000),
);

class TestConnection extends Connection {
  @override
  AppConnectionState build() => testConnection;

  void changeServer() {
    state = const AppConnectionState(
      status: ConnectionStatus.connected,
      baseUrl: 'http://another-server.com',
      health: testHealth,
    );
  }
}

class FakeSessionRepository implements SessionRepository {
  List<Session> sessions = [];
  Map<String, SessionStatus> statuses = {};
  final deletedIds = <String>[];
  Object? deleteError;
  Future<void>? pendingDeletion;
  CancelToken? deletionToken;

  @override
  Future<void> deleteSession(String id, {CancelToken? cancelToken}) async {
    deletedIds.add(id);
    deletionToken = cancelToken;
    final error = deleteError;
    if (error != null) throw error;
    await pendingDeletion;
    sessions = sessions.where((session) => session.id != id).toList();
  }

  final inputs = <CreateSessionInput>[];
  Object? createError;
  Object? listError;
  Future<List<Session>>? pendingSessions;
  Future<Session>? pendingCreation;
  CancelToken? creationToken;
  int listCalls = 0;

  @override
  Future<Session> createSession(
    CreateSessionInput input, {
    CancelToken? cancelToken,
  }) async {
    inputs.add(input);
    creationToken = cancelToken;
    final error = createError;
    if (error != null) throw error;
    final session = await (pendingCreation ?? Future.value(createdSession));
    sessions = [...sessions, session];
    return session;
  }

  @override
  Future<List<Session>> getSessions({
    String? directory,
    String? roots,
    int? limit,
    CancelToken? cancelToken,
  }) async {
    listCalls++;
    final error = listError;
    if (error != null) throw error;
    return pendingSessions ?? sessions;
  }

  @override
  Future<Map<String, SessionStatus>> getSessionStatus({
    String? directory,
    String? workspace,
    CancelToken? cancelToken,
  }) async => statuses;
}
