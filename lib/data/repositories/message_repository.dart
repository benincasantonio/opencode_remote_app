import 'package:dio/dio.dart';

import '../datasources/message_datasource.dart';

/// Orchestrates transcript retrieval for one session.
class MessageRepository {
  MessageRepository(this._datasource);

  final MessageDatasource _datasource;

  Future<MessageListResult> getMessages(
    String sessionId, {
    int? limit,
    String? before,
    CancelToken? cancelToken,
  }) => _datasource.getMessages(
    sessionId,
    limit: limit,
    before: before,
    cancelToken: cancelToken,
  );
}
