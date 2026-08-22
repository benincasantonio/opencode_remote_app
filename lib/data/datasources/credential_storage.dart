import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/errors/app_exception.dart';

/// Credentials for a single saved server.
///
/// Both fields are nullable: a server may expose no auth at all.
typedef ServerCredentials = ({String? username, String? password});

/// Storage for server credentials that must stay out of plain text.
abstract interface class CredentialStorage {
  /// Credentials for [serverId], or `null` when none are stored.
  Future<ServerCredentials?> get(String serverId);

  /// Stores non-null credential fields for [serverId].
  Future<void> save(String serverId, ServerCredentials credentials);

  /// Removes any stored credentials for [serverId].
  Future<void> delete(String serverId);
}

/// [CredentialStorage] backed by [FlutterSecureStorage].
class SecureCredentialStorage implements CredentialStorage {
  SecureCredentialStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static String _usernameKey(String serverId) => 'cred_${serverId}_username';
  static String _passwordKey(String serverId) => 'cred_${serverId}_password';

  @override
  Future<ServerCredentials?> get(String serverId) async {
    try {
      final username = await _storage.read(key: _usernameKey(serverId));
      final password = await _storage.read(key: _passwordKey(serverId));
      if (username == null && password == null) {
        return null;
      }
      return (username: username, password: password);
    } on Object catch (error, st) {
      throw CacheException('Failed to read credentials: $error', st);
    }
  }

  @override
  Future<void> save(String serverId, ServerCredentials credentials) async {
    try {
      final username = credentials.username;
      if (username != null) {
        await _storage.write(key: _usernameKey(serverId), value: username);
      }
      final password = credentials.password;
      if (password != null) {
        await _storage.write(key: _passwordKey(serverId), value: password);
      }
    } on Object catch (error, st) {
      throw CacheException('Failed to save credentials: $error', st);
    }
  }

  @override
  Future<void> delete(String serverId) async {
    try {
      await _storage.delete(key: _usernameKey(serverId));
      await _storage.delete(key: _passwordKey(serverId));
    } on Object catch (error, st) {
      throw CacheException('Failed to delete credentials: $error', st);
    }
  }
}
