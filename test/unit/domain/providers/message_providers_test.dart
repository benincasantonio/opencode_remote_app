import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/api_constants.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/data/datasources/message_datasource.dart';
import 'package:opencode_remote_app/data/repositories/message_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/message_providers.dart';

import '../../../support/message_test_support.dart';
import '../../../support/session_test_support.dart';

class _FakeMessageRepository implements MessageRepository {
  final results = <MessageListResult>[];
  final calls = <({String? before, int? limit, CancelToken? token})>[];
  Future<MessageListResult>? pending;
  Object? error;

  @override
  Future<MessageListResult> getMessages(
    String sessionId, {
    int? limit,
    String? before,
    CancelToken? cancelToken,
  }) async {
    calls.add((before: before, limit: limit, token: cancelToken));
    final failure = error;
    error = null;
    if (failure != null) throw failure;
    final gate = pending;
    pending = null;
    if (gate != null) return gate;
    if (results.isEmpty) return const MessageListResult(messages: []);
    return results.removeAt(0);
  }
}

void main() {
  late _FakeMessageRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeMessageRepository();
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        messageRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('sorts a page oldest-first and requests one page', () async {
    repository.results.add(
      MessageListResult(
        messages: [
          testUserMessage(id: 'msg_new', created: 20, text: 'new'),
          testUserMessage(id: 'msg_old', created: 10, text: 'old'),
        ],
      ),
    );
    container.listen(messagesProvider('ses_1'), (_, _) {});

    final transcript = await container.read(messagesProvider('ses_1').future);

    expect(repository.calls.single.limit, ApiConstants.messagePageLimit);
    expect(repository.calls.single.before, isNull);
    expect(transcript.messages.map((message) => message.info.id), [
      'msg_old',
      'msg_new',
    ]);
    expect(transcript.hasEarlier, isFalse);
  });

  test('refetches when the connection base URL changes', () async {
    container.listen(messagesProvider('ses_1'), (_, _) {});
    await container.read(messagesProvider('ses_1').future);
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await container.pump();

    expect(repository.calls, hasLength(2));
    expect(
      repository.calls.every(
        (call) => call.limit == ApiConstants.messagePageLimit,
      ),
      isTrue,
    );
  });

  test(
    'load earlier prepends using the oldest id when the page is full',
    () async {
      final newest = [
        for (
          var created = 0;
          created < ApiConstants.messagePageLimit;
          created++
        )
          testUserMessage(id: 'msg_$created', created: created),
      ];
      repository.results.add(
        MessageListResult(messages: newest.reversed.toList()),
      );
      container.listen(messagesProvider('ses_1'), (_, _) {});
      final first = await container.read(messagesProvider('ses_1').future);
      final last = ApiConstants.messagePageLimit - 1;
      expect(first.messages.first.info.id, 'msg_0');
      expect(first.messages.last.info.id, 'msg_$last');
      expect(first.hasEarlier, isTrue);

      repository.results.add(
        MessageListResult(
          messages: [testUserMessage(id: 'msg_older', created: -1)],
        ),
      );
      final ok = await container
          .read(messagesProvider('ses_1').notifier)
          .loadEarlier();

      expect(ok, isTrue);
      expect(repository.calls.last.before, 'msg_0');
      expect(repository.calls.last.limit, ApiConstants.messagePageLimit);
      final merged = container.read(messagesProvider('ses_1')).requireValue;
      expect(merged.messages.first.info.id, 'msg_older');
      expect(merged.messages.last.info.id, 'msg_$last');
      expect(merged.hasEarlier, isFalse);
    },
  );

  test('load earlier uses X-Next-Cursor when the server sends one', () async {
    repository.results.add(
      MessageListResult(
        messages: [testUserMessage(id: 'msg_new', created: 2)],
        nextCursor: 'opaque-cursor',
      ),
    );
    container.listen(messagesProvider('ses_1'), (_, _) {});
    final first = await container.read(messagesProvider('ses_1').future);
    expect(first.hasEarlier, isTrue);

    repository.results.add(
      MessageListResult(messages: [testUserMessage(id: 'msg_old', created: 1)]),
    );
    await container.read(messagesProvider('ses_1').notifier).loadEarlier();

    expect(repository.calls.last.before, 'opaque-cursor');
    expect(
      container
          .read(messagesProvider('ses_1'))
          .requireValue
          .messages
          .map((message) => message.info.id),
      ['msg_old', 'msg_new'],
    );
  });

  test(
    'a failed earlier page keeps the transcript already on screen',
    () async {
      repository.results.add(
        MessageListResult(
          messages: [testUserMessage(id: 'msg_new', created: 2)],
          nextCursor: 'opaque-cursor',
        ),
      );
      container.listen(messagesProvider('ses_1'), (_, _) {});
      await container.read(messagesProvider('ses_1').future);
      repository.error = const NetworkException('offline');

      final ok = await container
          .read(messagesProvider('ses_1').notifier)
          .loadEarlier();

      expect(ok, isFalse);
      final transcript = container.read(messagesProvider('ses_1'));
      expect(transcript.hasError, isFalse);
      expect(transcript.requireValue.messages.single.info.id, 'msg_new');
      expect(transcript.requireValue.hasEarlier, isTrue);
    },
  );
}
