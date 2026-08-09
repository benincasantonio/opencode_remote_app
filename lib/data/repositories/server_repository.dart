import '../datasources/server_datasource.dart';
import '../models/server_health.dart';

/// Orchestrates server health checks for the Connect flow.
class ServerRepository {
  ServerRepository(this._datasource);

  final ServerDatasource _datasource;

  /// One-shot health check against the configured OpenCode server.
  Future<ServerHealth> getHealth() => _datasource.getHealth();
}
