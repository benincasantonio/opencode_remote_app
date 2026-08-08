import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';

part 'part.freezed.dart';
part 'part.g.dart';

@freezed
sealed class PartTime with _$PartTime {
  const factory PartTime({
    required int start,
    int? end,
  }) = _PartTime;

  factory PartTime.fromJson(Map<String, dynamic> json) => _$PartTimeFromJson(json);
}

@freezed
sealed class ToolTimeStart with _$ToolTimeStart {
  const factory ToolTimeStart({
    required int start,
  }) = _ToolTimeStart;

  factory ToolTimeStart.fromJson(Map<String, dynamic> json) => _$ToolTimeStartFromJson(json);
}

@freezed
sealed class ToolTimeFull with _$ToolTimeFull {
  const factory ToolTimeFull({
    required int start,
    required int end,
    int? compacted,
  }) = _ToolTimeFull;

  factory ToolTimeFull.fromJson(Map<String, dynamic> json) => _$ToolTimeFullFromJson(json);
}

@Freezed(unionKey: 'status')
sealed class ToolState with _$ToolState {
  const factory ToolState.pending({
    required Map<String, dynamic> input,
    required String raw,
  }) = ToolStatePending;

  const factory ToolState.running({
    required Map<String, dynamic> input,
    String? title,
    Map<String, dynamic>? metadata,
    required ToolTimeStart time,
  }) = ToolStateRunning;

  const factory ToolState.completed({
    required Map<String, dynamic> input,
    required String output,
    required String title,
    required Map<String, dynamic> metadata,
    required ToolTimeFull time,
  }) = ToolStateCompleted;

  const factory ToolState.error({
    required Map<String, dynamic> input,
    required String error,
    Map<String, dynamic>? metadata,
    required ToolTimeFull time,
  }) = ToolStateError;

  factory ToolState.fromJson(Map<String, dynamic> json) => _$ToolStateFromJson(json);
}

@Freezed(unionKey: 'type', fallbackUnion: 'other')
sealed class MessagePart with _$MessagePart {
  const factory MessagePart.text({
    required String id,
    required String sessionID,
    required String messageID,
    required String text,
    bool? synthetic,
    bool? ignored,
    PartTime? time,
    Map<String, dynamic>? metadata,
  }) = TextPart;

  const factory MessagePart.reasoning({
    required String id,
    required String sessionID,
    required String messageID,
    required String text,
    Map<String, dynamic>? metadata,
    required PartTime time,
  }) = ReasoningPart;

  const factory MessagePart.tool({
    required String id,
    required String sessionID,
    required String messageID,
    required String callID,
    required String tool,
    required ToolState state,
    Map<String, dynamic>? metadata,
  }) = ToolPart;

  @FreezedUnionValue('step-start')
  const factory MessagePart.stepStart({
    required String id,
    required String sessionID,
    required String messageID,
    String? snapshot,
  }) = StepStartPart;

  @FreezedUnionValue('step-finish')
  const factory MessagePart.stepFinish({
    required String id,
    required String sessionID,
    required String messageID,
    required String reason,
    String? snapshot,
    required double cost,
    required Tokens tokens,
  }) = StepFinishPart;

  const factory MessagePart.other({
    required String id,
    required String sessionID,
    required String messageID,
    required String type,
  }) = OtherPart;

  factory MessagePart.fromJson(Map<String, dynamic> json) => _$MessagePartFromJson(json);
}
