import 'dart:math';

import '../datasources/credential_storage.dart';
import '../datasources/server_storage_datasource.dart';
import '../models/saved_server.dart';

/// Orchestrates the persisted server list and their secure credentials.
class SavedServerRepository {
  SavedServerRepository(this._storage, this._credentials);

  final ServerStorageDatasource _storage;
  final CredentialStorage _credentials;

  static final Random _idRandom = Random();

  /// All saved servers (metadata only, no credentials).
  Future<List<SavedServer>> getAll() => _storage.getAll();

  /// The explicit default server, or the most recently connected one when no
  /// default is set. `null` when nothing has been saved yet.
  Future<SavedServer?> getDefault() async {
    final servers = await _storage.getAll();
    if (servers.isEmpty) {
      return null;
    }
    for (final server in servers) {
      if (server.isDefault) {
        return server;
      }
    }
    final byLastConnected = [...servers]..sort((a, b) {
        final aTime = a.lastConnectedAt?.millisecondsSinceEpoch ?? 0;
        final bTime = b.lastConnectedAt?.millisecondsSinceEpoch ?? 0;
        return bTime.compareTo(aTime);
      });
    return byLastConnected.first;
  }

  /// Upserts a server by host:port and stores its credentials securely.
  ///
  /// The first saved server becomes the default. `null` credentials clear
  /// any previously stored credentials for the same server.
  Future<SavedServer> save({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    final trimmedHost = host.trim();
    final servers = await _storage.getAll();
    final existing = _findByHostPort(servers, trimmedHost, port);

    final server = (existing ??
        SavedServer(id: _generateId(), host: trimmedHost, port: port)).copyWith(
      host: trimmedHost,
      port: port,
      isDefault: existing?.isDefault ?? servers.isEmpty,
      lastConnectedAt: DateTime.now(),
    );

    if (username != null || password != null) {
      await _credentials.save(
        server.id,
        (username: username, password: password),
      );
    } else {
      await _credentials.delete(server.id);
    }

    final updated = [
      for (final saved in servers)
        if (saved.id != server.id) saved,
      server,
    ];
    await _storage.saveAll(updated);
    return server;
  }

  /// Removes the server and its stored credentials.
  ///
  /// When the default server is deleted, the remaining oldest server becomes
  /// the new default.
  Future<void> delete(String id) async {
    var remaining = [
      for (final server in await _storage.getAll())
        if (server.id != id) server,
    ];
    if (remaining.isNotEmpty && remaining.every((s) => !s.isDefault)) {
      remaining = [
        for (var i = 0; i < remaining.length; i++)
          remaining[i].copyWith(isDefault: i == 0),
      ];
    }
    await _storage.saveAll(remaining);
    await _credentials.delete(id);
  }

  /// Marks [id] as the default and clears the flag on every other server.
  Future<void> setDefault(String id) async {
    final servers = await _storage.getAll();
    await _storage.saveAll([
      for (final server in servers)
        server.copyWith(isDefault: server.id == id),
    ]);
  }

  /// Credentials for [id], or `null` when none are stored.
  Future<ServerCredentials?> getCredentials(String id) =>
      _credentials.get(id);

  static SavedServer? _findByHostPort(
    List<SavedServer> servers,
    String host,
    int port,
  ) {
    for (final server in servers) {
      if (server.host == host && server.port == port) {
        return server;
      }
    }
    return null;
  }

  static String _generateId() {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    return '${timestamp}_${_idRandom.nextInt(0xFFFFFF)}';
  }
}
