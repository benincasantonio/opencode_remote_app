import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/models/message.dart';
import 'package:opencode_remote_app/data/models/part.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/message_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/chat/chat_empty_view.dart';
import 'package:opencode_remote_app/presentation/screens/chat/chat_screen.dart';
import 'package:opencode_remote_app/presentation/screens/chat/load_earlier_button.dart';
import 'package:opencode_remote_app/presentation/screens/chat/message_bubble.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator.dart';

import '../../../../support/message_test_support.dart';

const _sessionId = 'ses_1';

const _session = Session(
  id: _sessionId,
  slug: 'bug-hunt',
  projectID: 'global',
  directory: '/Users/test',
  title: 'Bug hunt',
  version: '1.0.0',
  time: SessionTime(created: 1, updated: 2),
);

MessageWithParts _assistantMessage() {
  return MessageWithParts(
    info: const Message.assistant(
      id: 'msg_asst',
      sessionID: _sessionId,
      time: AssistantTime(created: 2),
      parentID: 'msg_user',
      modelID: 'gpt',
      providerID: 'openai',
      mode: 'build',
      agent: 'build',
      path: MessagePath(cwd: '/', root: '/'),
      cost: 0,
      tokens: Tokens(
        input: 0,
        output: 0,
        reasoning: 0,
        cache: CacheTokens(read: 0, write: 0),
      ),
      error: MessageError(
        name: 'MessageAbortedError',
        data: {'message': 'Aborted'},
      ),
    ),
    parts: const [
      MessagePart.reasoning(
        id: 'prt_empty',
        sessionID: _sessionId,
        messageID: 'msg_asst',
        text: '   ',
        time: PartTime(start: 1),
      ),
      MessagePart.reasoning(
        id: 'prt_reason',
        sessionID: _sessionId,
        messageID: 'msg_asst',
        text: 'thinking about it',
        time: PartTime(start: 2),
      ),
      MessagePart.text(
        id: 'prt_text',
        sessionID: _sessionId,
        messageID: 'msg_asst',
        text: 'Hello from assistant',
      ),
      MessagePart.tool(
        id: 'prt_tool',
        sessionID: _sessionId,
        messageID: 'msg_asst',
        callID: 'call_1',
        tool: 'glob',
        state: ToolState.pending(input: <String, dynamic>{}, raw: ''),
      ),
      MessagePart.stepStart(
        id: 'prt_step',
        sessionID: _sessionId,
        messageID: 'msg_asst',
      ),
      MessagePart.other(
        id: 'prt_other',
        sessionID: _sessionId,
        messageID: 'msg_asst',
        type: 'patch',
      ),
    ],
  );
}

class _ScriptedMessages extends Messages {
  _ScriptedMessages(this._load);

  final Future<Transcript> Function() _load;
  var earlierCalls = 0;

  @override
  Future<Transcript> build(String sessionId) => _load();

  @override
  Future<bool> loadEarlier() async {
    earlierCalls++;
    return true;
  }
}

class _RetryMessages extends Messages {
  var calls = 0;

  @override
  Future<Transcript> build(String sessionId) async {
    calls++;
    if (calls == 1) throw const NetworkException('offline');
    return Transcript(
      messages: [
        testUserMessage(id: 'msg_user', created: 1, text: 'Hello from user'),
      ],
      hasEarlier: false,
    );
  }
}

void main() {
  const healthy = ServerHealth(healthy: true, version: '1.0.0');

  Future<void> pumpChat(
    WidgetTester tester, {
    required Messages Function() create,
  }) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          connectionProvider.overrideWithValue(
            const AppConnectionState(
              status: ConnectionStatus.connected,
              baseUrl: 'http://127.0.0.1:4096',
              displayName: '127.0.0.1:4096',
              health: healthy,
            ),
          ),
          healthPollingProvider.overrideWith((ref) => Stream.value(healthy)),
          sessionsListProvider.overrideWith((ref) async => const [_session]),
          messagesProvider.overrideWith(create),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ChatScreen(sessionId: _sessionId),
        ),
      ),
    );
  }

  testWidgets('shows a loading indicator while the transcript loads', (
    tester,
  ) async {
    await pumpChat(
      tester,
      create: () => _ScriptedMessages(() => Completer<Transcript>().future),
    );
    await tester.pump();

    expect(find.byType(LoadingIndicator), findsOneWidget);
    expect(find.byType(MessageBubble), findsNothing);
    expect(find.text('Bug hunt'), findsOneWidget);
  });

  testWidgets('renders user text above assistant text', (tester) async {
    final transcript = Transcript(
      messages: [
        testUserMessage(id: 'msg_user', created: 1, text: 'Hello from user'),
        _assistantMessage(),
      ],
      hasEarlier: false,
    );
    await pumpChat(
      tester,
      create: () => _ScriptedMessages(() async => transcript),
    );
    await tester.pumpAndSettle();

    expect(find.text('You'), findsOneWidget);
    expect(find.text('Assistant'), findsOneWidget);
    expect(find.textContaining('Hello from user'), findsOneWidget);
    expect(find.textContaining('Hello from assistant'), findsOneWidget);
    expect(find.text('thinking about it'), findsOneWidget);
    expect(find.text('glob · Pending'), findsOneWidget);
    expect(find.text('Aborted'), findsOneWidget);
    expect(find.text('patch'), findsOneWidget);
    expect(find.text('step-start'), findsNothing);
    expect(
      tester.getTopLeft(find.textContaining('Hello from user')).dy,
      lessThan(
        tester.getTopLeft(find.textContaining('Hello from assistant')).dy,
      ),
    );
    expect(find.byType(LoadEarlierButton), findsNothing);
  });

  testWidgets('shows an error and retry loads the transcript', (tester) async {
    final messages = _RetryMessages();
    await pumpChat(tester, create: () => messages);
    await tester.pumpAndSettle();

    expect(find.byType(AppErrorWidget), findsOneWidget);
    expect(find.text('Could not load messages'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Hello from user'), findsOneWidget);
    expect(find.byType(AppErrorWidget), findsNothing);
    expect(messages.calls, 2);
  });

  testWidgets('shows an empty transcript', (tester) async {
    await pumpChat(
      tester,
      create: () => _ScriptedMessages(
        () async => const Transcript(messages: [], hasEarlier: false),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ChatEmptyView), findsOneWidget);
    expect(find.text('No messages yet'), findsOneWidget);
    expect(find.text('This session has no messages.'), findsOneWidget);
    expect(find.byType(MessageBubble), findsNothing);
  });

  testWidgets('load earlier is offered when another page exists', (
    tester,
  ) async {
    final messages = _ScriptedMessages(
      () async => Transcript(
        messages: [
          testUserMessage(id: 'msg_user', created: 1, text: 'Hello from user'),
        ],
        hasEarlier: true,
      ),
    );
    await pumpChat(tester, create: () => messages);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Load earlier'));
    await tester.pump();

    expect(messages.earlierCalls, 1);
  });
}
