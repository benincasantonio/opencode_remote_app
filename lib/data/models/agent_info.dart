import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_info.freezed.dart';
part 'agent_info.g.dart';

/// Fields used to select a primary session agent from GET /agent.
@freezed
sealed class AgentInfo with _$AgentInfo {
  const factory AgentInfo({
    required String name,
    required String mode,
    String? description,
    @Default(false) bool hidden,
  }) = _AgentInfo;

  factory AgentInfo.fromJson(Map<String, dynamic> json) =>
      _$AgentInfoFromJson(json);
}
