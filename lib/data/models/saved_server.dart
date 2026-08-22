import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_server.freezed.dart';
part 'saved_server.g.dart';

/// A server the user has connected to before, persisted on-device.
///
/// Credentials (username/password) are never stored here — they live in
/// secure storage keyed by [id]. [lastConnectedAt] is informational only.
@freezed
sealed class SavedServer with _$SavedServer {
  const SavedServer._();

  const factory SavedServer({
    required String id,
    required String host,
    required int port,
    @Default(false) bool isDefault,
    DateTime? lastConnectedAt,
  }) = _SavedServer;

  factory SavedServer.fromJson(Map<String, dynamic> json) =>
      _$SavedServerFromJson(json);

  /// User-facing label, e.g. `192.168.1.10:4096`.
  String get displayName => '$host:$port';
}
