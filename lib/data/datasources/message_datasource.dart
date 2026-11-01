import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/errors/app_exception.dart';
import '../models/message.dart';

/// One page of `GET /session/:id/message`.
///
/// [nextCursor] is the `X-Next-Cursor` header when the server has older
/// messages. The body itself is only the message list.
class MessageListResult {
  const MessageListResult({required this.messages, this.nextCursor});

  final List<MessageWithParts> messages;
  final String? nextCursor;
}

/// HTTP datasource for OpenCode session message endpoints.
class MessageDatasource {
  MessageDatasource(this._dio);

  final Dio _dio;

  /// GET [/session/:id/message](ApiConstants.messagePath).
  Future<MessageListResult> getMessages(
    String sessionId, {
    int? limit,
    String? before,
    CancelToken? cancelToken,
  }) => _request(() async {
    final queryParams = <String, dynamic>{'limit': ?limit, 'before': ?before};

    final response = await _dio.get<List<dynamic>>(
      ApiConstants.messagePath(sessionId),
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null) {
      throw const ParseException('Empty message list response');
    }

    final messages = data
        .map((item) => MessageWithParts.fromJson(item as Map<String, dynamic>))
        .toList();
    final cursor = response.headers.value('x-next-cursor');
    return MessageListResult(
      messages: messages,
      nextCursor: (cursor == null || cursor.isEmpty) ? null : cursor,
    );
  });

  Future<T> _request<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      final mapped = error.error;
      if (mapped is AppException) throw mapped;
      if (mapped is TypeError || mapped is FormatException) {
        throw ParseException(
          'Failed to parse message response: $mapped',
          stackTrace: error.stackTrace,
        );
      }
      rethrow;
    } on AppException {
      rethrow;
    } on Object catch (error, st) {
      throw ParseException(
        'Failed to parse message response: $error',
        stackTrace: st,
      );
    }
  }
}
