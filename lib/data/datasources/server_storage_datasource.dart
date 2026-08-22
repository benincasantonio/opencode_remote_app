import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/errors/app_exception.dart';
import '../models/saved_server.dart';

/// Persists the list of [SavedServer] entries via [SharedPreferences].
///
/// Metadata only — credentials never touch plain-text preferences.
class ServerStorageDatasource {
  static const _savedServersKey = 'saved_servers_v1';

  SharedPreferences? _preferences;

  Future<SharedPreferences> _get() async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  /// All saved servers, oldest first. Empty when nothing was saved yet.
  Future<List<SavedServer>> getAll() async {
    final prefs = await _get();
    final raw = prefs.getString(_savedServersKey);
    if (raw == null) {
      return const [];
    }
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return [
        for (final item in decoded)
          SavedServer.fromJson(item as Map<String, dynamic>),
      ];
    } on Object catch (error, st) {
      throw CacheException('Failed to read saved servers: $error', st);
    }
  }

  /// Replaces the full saved-server list.
  Future<void> saveAll(List<SavedServer> servers) async {
    final prefs = await _get();
    try {
      final encoded = jsonEncode([
        for (final server in servers) server.toJson(),
      ]);
      await prefs.setString(_savedServersKey, encoded);
    } on Object catch (error, st) {
      throw CacheException('Failed to save servers: $error', st);
    }
  }
}
