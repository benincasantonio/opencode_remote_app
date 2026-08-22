import 'package:opencode_remote_app/data/datasources/credential_storage.dart';
import 'package:opencode_remote_app/data/datasources/server_storage_datasource.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';

/// In-memory [ServerStorageDatasource] for tests.
class FakeServerStorage extends ServerStorageDatasource {
  FakeServerStorage([List<SavedServer>? initial])
    : _servers = [...?initial];

  final List<SavedServer> _servers;

  @override
  Future<List<SavedServer>> getAll() async => List.of(_servers);

  @override
  Future<void> saveAll(List<SavedServer> servers) async {
    _servers
      ..clear()
      ..addAll(servers);
  }
}

/// In-memory [CredentialStorage] for tests.
class FakeCredentialStorage implements CredentialStorage {
  FakeCredentialStorage([Map<String, ServerCredentials>? initial])
    : _store = {...?initial};

  final Map<String, ServerCredentials> _store;

  @override
  Future<ServerCredentials?> get(String serverId) async => _store[serverId];

  @override
  Future<void> save(String serverId, ServerCredentials credentials) async {
    _store[serverId] = credentials;
  }

  @override
  Future<void> delete(String serverId) async {
    _store.remove(serverId);
  }
}
