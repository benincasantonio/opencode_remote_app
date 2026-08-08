import 'package:freezed_annotation/freezed_annotation.dart';

import 'part.dart';
import 'session.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
sealed class UserTime with _$UserTime {
  const factory UserTime({
    required int created,
  }) = _UserTime;

  factory UserTime.fromJson(Map<String, dynamic> json) => _$UserTimeFromJson(json);
}

@freezed
sealed class AssistantTime with _$AssistantTime {
  const factory AssistantTime({
    required int created,
    int? completed,
  }) = _AssistantTime;

  factory AssistantTime.fromJson(Map<String, dynamic> json) => _$AssistantTimeFromJson(json);
}

@freezed
sealed class MessagePath with _$MessagePath {
  const factory MessagePath({
    required String cwd,
    required String root,
  }) = _MessagePath;

  factory MessagePath.fromJson(Map<String, dynamic> json) => _$MessagePathFromJson(json);
}

@freezed
sealed class MessageSummary with _$MessageSummary {
  const factory MessageSummary({
    String? title,
    String? body,
    required List<dynamic> diffs,
  }) = _MessageSummary;

  factory MessageSummary.fromJson(Map<String, dynamic> json) =>
      _$MessageSummaryFromJson(json);
}

@freezed
sealed class MessageError with _$MessageError {
  const MessageError._();

  const factory MessageError({
    required String name,
    Map<String, dynamic>? data,
  }) = _MessageError;

  factory MessageError.fromJson(Map<String, dynamic> json) => _$MessageErrorFromJson(json);

  @JsonKey(includeToJson: false)
  String get message => (data?['message'] as String?) ?? '';
}

@Freezed(unionKey: 'type')
sealed class OutputFormat with _$OutputFormat {
  const factory OutputFormat.text() = OutputFormatText;

  @FreezedUnionValue('json_schema')
  const factory OutputFormat.jsonSchema({
    required Map<String, dynamic> schema,
    required int retryCount,
  }) = OutputFormatJsonSchema;

  factory OutputFormat.fromJson(Map<String, dynamic> json) =>
      _$OutputFormatFromJson(json);
}

@Freezed(unionKey: 'role')
sealed class Message with _$Message {
  const factory Message.user({
    required String id,
    required String sessionID,
    required UserTime time,
    required String agent,
    required ModelRef model,
    OutputFormat? format,
    MessageSummary? summary,
    String? system,
    Map<String, bool>? tools,
  }) = UserMessage;

  const factory Message.assistant({
    required String id,
    required String sessionID,
    required AssistantTime time,
    required String parentID,
    required String modelID,
    required String providerID,
    required String mode,
    required String agent,
    required MessagePath path,
    required double cost,
    required Tokens tokens,
    MessageError? error,
    String? finish,
    String? variant,
    dynamic structured,
  }) = AssistantMessage;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

@freezed
sealed class MessageWithParts with _$MessageWithParts {
  const factory MessageWithParts({
    required Message info,
    required List<MessagePart> parts,
  }) = _MessageWithParts;

  factory MessageWithParts.fromJson(Map<String, dynamic> json) =>
      _$MessageWithPartsFromJson(json);
}
