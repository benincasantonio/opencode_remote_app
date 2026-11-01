import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/datasources/message_datasource.dart';
import 'package:opencode_remote_app/data/repositories/message_repository.dart';

import '../../../support/message_test_support.dart';

class _FakeMessageDatasource implements MessageDatasource {
  MessageListResult result = const MessageListResult(messages: []);
  Object? error;
  String? lastSessionId;
  int? lastLimit;
  String? lastBefore;
  CancelToken? lastCancelToken;

  @override
  Future<MessageListResult> getMessages(
    String sessionId, {
    int? limit,
    String? before,
    CancelToken? cancelToken,
  }) async {
    lastSessionId = sessionId;
    lastLimit = limit;
    lastBefore = before;
    lastCancelToken = cancelToken;
    final failure = error;
    if (failure != null) throw failure;
    return result;
  }
}

void main() {
  test('forwards paging arguments and the page result', () async {
    final datasource = _FakeMessageDatasource();
    final message = testUserMessage(id: 'msg_1', created: 1);
    datasource.result = MessageListResult(
      messages: [message],
      nextCursor: 'cursor-1',
    );
    final token = CancelToken();
    final repository = MessageRepository(datasource);

    final page = await repository.getMessages(
      'ses_1',
      limit: 50,
      before: 'msg_0',
      cancelToken: token,
    );

    expect(datasource.lastSessionId, 'ses_1');
    expect(datasource.lastLimit, 50);
    expect(datasource.lastBefore, 'msg_0');
    expect(identical(datasource.lastCancelToken, token), isTrue);
    expect(page.nextCursor, 'cursor-1');
    expect(page.messages.single.info.id, 'msg_1');
  });

  test('rethrows datasource errors', () async {
    final datasource = _FakeMessageDatasource()
      ..error = const NetworkException('offline');
    final repository = MessageRepository(datasource);

    expect(
      () => repository.getMessages('ses_1'),
      throwsA(isA<NetworkException>()),
    );
  });
}
