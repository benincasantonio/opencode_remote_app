import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_health.freezed.dart';
part 'server_health.g.dart';

/// Response from `GET /global/health`.
@freezed
sealed class ServerHealth with _$ServerHealth {
  const factory ServerHealth({
    required bool healthy,
    required String version,
  }) = _ServerHealth;

  factory ServerHealth.fromJson(Map<String, dynamic> json) =>
      _$ServerHealthFromJson(json);
}
