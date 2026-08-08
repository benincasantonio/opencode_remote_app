// ignore_for_file: invalid_annotation_target

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

@freezed
sealed class RetryTime with _$RetryTime {
  const factory RetryTime({
    required int created,
  }) = _RetryTime;

  factory RetryTime.fromJson(Map<String, dynamic> json) => _$RetryTimeFromJson(json);
}

@freezed
sealed class AgentPartSource with _$AgentPartSource {
  const factory AgentPartSource({
    required String value,
    required int start,
    required int end,
  }) = _AgentPartSource;

  factory AgentPartSource.fromJson(Map<String, dynamic> json) =>
      _$AgentPartSourceFromJson(json);
}

@freezed
sealed class FileSourceText with _$FileSourceText {
  const factory FileSourceText({
    required String value,
    required double start,
    required double end,
  }) = _FileSourceText;

  factory FileSourceText.fromJson(Map<String, dynamic> json) =>
      _$FileSourceTextFromJson(json);
}

@freezed
sealed class Position with _$Position {
  const factory Position({
    required int line,
    required int character,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
}

@freezed
sealed class Range with _$Range {
  const factory Range({
    required Position start,
    required Position end,
  }) = _Range;

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);
}

@freezed
sealed class ApiError with _$ApiError {
  const ApiError._();

  const factory ApiError({
    required String name,
    Map<String, dynamic>? data,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  @JsonKey(includeToJson: false)
  String get message => (data?['message'] as String?) ?? '';
}

@Freezed(unionKey: 'type')
sealed class FilePartSource with _$FilePartSource {
  const factory FilePartSource.file({
    required FileSourceText text,
    required String path,
  }) = FileSource;

  const factory FilePartSource.symbol({
    required FileSourceText text,
    required String path,
    required Range range,
    required String name,
    required int kind,
  }) = SymbolSource;

  const factory FilePartSource.resource({
    required FileSourceText text,
    required String clientName,
    required String uri,
  }) = ResourceSource;

  factory FilePartSource.fromJson(Map<String, dynamic> json) =>
      _$FilePartSourceFromJson(json);
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
    List<FilePart>? attachments,
  }) = ToolStateCompleted;

  const factory ToolState.error({
    required Map<String, dynamic> input,
    required String error,
    Map<String, dynamic>? metadata,
    required ToolTimeFull time,
  }) = ToolStateError;

  factory ToolState.fromJson(Map<String, dynamic> json) => _$ToolStateFromJson(json);
}

@Freezed(unionKey: 'type')
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

  const factory MessagePart.file({
    required String id,
    required String sessionID,
    required String messageID,
    required String mime,
    String? filename,
    required String url,
    FilePartSource? source,
  }) = FilePart;

  const factory MessagePart.snapshot({
    required String id,
    required String sessionID,
    required String messageID,
    required String snapshot,
  }) = SnapshotPart;

  const factory MessagePart.patch({
    required String id,
    required String sessionID,
    required String messageID,
    required String hash,
    required List<String> files,
  }) = PatchPart;

  const factory MessagePart.agent({
    required String id,
    required String sessionID,
    required String messageID,
    required String name,
    AgentPartSource? source,
  }) = AgentPart;

  const factory MessagePart.retry({
    required String id,
    required String sessionID,
    required String messageID,
    required int attempt,
    required ApiError error,
    required RetryTime time,
  }) = RetryPart;

  const factory MessagePart.compaction({
    required String id,
    required String sessionID,
    required String messageID,
    required bool auto,
    bool? overflow,
    @JsonKey(name: 'tail_start_id') String? tailStartID,
  }) = CompactionPart;

  const factory MessagePart.subtask({
    required String id,
    required String sessionID,
    required String messageID,
    required String prompt,
    required String description,
    required String agent,
    ModelRef? model,
    String? command,
  }) = SubtaskPart;

  factory MessagePart.fromJson(Map<String, dynamic> json) =>
      _$MessagePartFromJson(json);
}
