import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
sealed class Session with _$Session {
  const factory Session({
    required String id,
    required String slug,
    required String projectID,
    String? workspaceID,
    required String directory,
    String? path,
    String? parentID,
    SessionSummary? summary,
    double? cost,
    Tokens? tokens,
    SessionShare? share,
    required String title,
    String? agent,
    SessionModel? model,
    required String version,
    Map<String, dynamic>? metadata,
    List<dynamic>? permission,
    SessionRevert? revert,
    required SessionTime time,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}

@freezed
sealed class SessionTime with _$SessionTime {
  const factory SessionTime({
    required int created,
    required int updated,
    int? compacting,
    int? archived,
  }) = _SessionTime;

  factory SessionTime.fromJson(Map<String, dynamic> json) => _$SessionTimeFromJson(json);
}

@freezed
sealed class CacheTokens with _$CacheTokens {
  const factory CacheTokens({
    required double read,
    required double write,
  }) = _CacheTokens;

  factory CacheTokens.fromJson(Map<String, dynamic> json) => _$CacheTokensFromJson(json);
}

@freezed
sealed class Tokens with _$Tokens {
  const factory Tokens({
    double? total,
    required double input,
    required double output,
    required double reasoning,
    required CacheTokens cache,
  }) = _Tokens;

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
}

@freezed
sealed class SessionSummary with _$SessionSummary {
  const factory SessionSummary({
    required double additions,
    required double deletions,
    required double files,
    List<dynamic>? diffs,
  }) = _SessionSummary;

  factory SessionSummary.fromJson(Map<String, dynamic> json) => _$SessionSummaryFromJson(json);
}

@freezed
sealed class SessionShare with _$SessionShare {
  const factory SessionShare({
    required String url,
  }) = _SessionShare;

  factory SessionShare.fromJson(Map<String, dynamic> json) => _$SessionShareFromJson(json);
}

@freezed
sealed class SessionRevert with _$SessionRevert {
  const factory SessionRevert({
    required String messageID,
    String? partID,
    String? snapshot,
    String? diff,
  }) = _SessionRevert;

  factory SessionRevert.fromJson(Map<String, dynamic> json) => _$SessionRevertFromJson(json);
}

@freezed
sealed class SessionModel with _$SessionModel {
  const factory SessionModel({
    required String id,
    required String providerID,
    String? variant,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) => _$SessionModelFromJson(json);
}

@freezed
sealed class ModelRef with _$ModelRef {
  const factory ModelRef({
    required String modelID,
    required String providerID,
    String? variant,
  }) = _ModelRef;

  factory ModelRef.fromJson(Map<String, dynamic> json) => _$ModelRefFromJson(json);
}

@freezed
sealed class RetryAction with _$RetryAction {
  const factory RetryAction({
    required String reason,
    required String provider,
    required String title,
    required String message,
    required String label,
    String? link,
  }) = _RetryAction;

  factory RetryAction.fromJson(Map<String, dynamic> json) => _$RetryActionFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class SessionStatus with _$SessionStatus {
  const factory SessionStatus.idle() = SessionStatusIdle;

  const factory SessionStatus.busy() = SessionStatusBusy;

  const factory SessionStatus.retry({
    required int attempt,
    required String message,
    RetryAction? action,
    required int next,
  }) = SessionStatusRetry;

  factory SessionStatus.fromJson(Map<String, dynamic> json) =>
      _$SessionStatusFromJson(json);
}

@freezed
sealed class CreateSessionInput with _$CreateSessionInput {
  const factory CreateSessionInput({
    String? parentID,
    String? title,
    String? agent,
    SessionModel? model,
    Map<String, dynamic>? metadata,
    List<dynamic>? permission,
    String? workspaceID,
  }) = _CreateSessionInput;

  factory CreateSessionInput.fromJson(Map<String, dynamic> json) =>
      _$CreateSessionInputFromJson(json);
}
