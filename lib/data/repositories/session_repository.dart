import 'package:dio/dio.dart';

import '../datasources/session_datasource.dart';
import '../models/session.dart';

/// Orchestrates session retrieval and status queries.
class SessionRepository {
  SessionRepository(this._datasource);

  final SessionDatasource _datasource;

  /// Fetches the list of sessions from the OpenCode server.
  Future<List<Session>> getSessions({
    String? directory,
    String? roots,
    int? limit,
    CancelToken? cancelToken,
  }) => _datasource.getSessions(
    directory: directory,
    roots: roots,
    limit: limit,
    cancelToken: cancelToken,
  );

  /// Fetches the map of session statuses from the OpenCode server.
  Future<Map<String, SessionStatus>> getSessionStatus({
    String? directory,
    String? workspace,
    CancelToken? cancelToken,
  }) => _datasource.getSessionStatus(
    directory: directory,
    workspace: workspace,
    cancelToken: cancelToken,
  );
}
