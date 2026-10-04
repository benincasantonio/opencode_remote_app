import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/core/theme/app_theme.dart';
import 'package:opencode_remote_app/data/models/agent_info.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/agent_providers.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/new_session_dialog.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_tile.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/sessions_list_screen.dart';

import '../../../../support/session_test_support.dart';

const _agents = [
  AgentInfo(name: 'build', mode: 'primary'),
  AgentInfo(name: 'plan', mode: 'primary'),
];

Future<void> _pumpScreen(
  WidgetTester tester,
  FakeSessionRepository repository, {
  FutureOr<List<AgentInfo>> Function()? loadAgents,
  double textScale = 1,
  double keyboardHeight = 0,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        healthPollingProvider.overrideWith((ref) => Stream.value(testHealth)),
        sessionRepositoryProvider.overrideWithValue(repository),
        sessionAgentsProvider.overrideWith(
          (ref) => loadAgents?.call() ?? _agents,
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
            viewInsets: EdgeInsets.only(bottom: keyboardHeight),
          ),
          child: child ?? const SizedBox.shrink(),
        ),
        home: const SessionsListScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

Future<void> _chooseAgent(WidgetTester tester, String name) async {
  await tester.tap(find.byType(DropdownButtonFormField<String>));
  await tester.pumpAndSettle();
  await tester.tap(find.text(name).last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('FAB opens labeled dialog and cancel never submits', (
    tester,
  ) async {
    final repository = FakeSessionRepository();
    await _pumpScreen(tester, repository);
    expect(find.byType(NewSessionDialog), findsOneWidget);
    expect(find.text('Title (optional)'), findsOneWidget);
    expect(find.text('Agent (optional)'), findsOneWidget);
    expect(find.text('Server default'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(NewSessionDialog), findsNothing);
    expect(repository.inputs, isEmpty);
  });

  testWidgets(
    'title and selected agent create session and refresh the real list provider',
    (tester) async {
      final repository = FakeSessionRepository();
      await _pumpScreen(tester, repository);
      await tester.enterText(find.byType(TextField), '  Fix bug  ');
      await _chooseAgent(tester, 'build');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();
      expect(repository.inputs, [
        const CreateSessionInput(title: 'Fix bug', agent: 'build'),
      ]);
      expect(find.byType(NewSessionDialog), findsNothing);
      expect(find.byType(SessionTile), findsOneWidget);
      expect(find.text(createdSession.title), findsOneWidget);
      expect(repository.listCalls, 2);
    },
  );

  testWidgets('blank title and switching back to server default omit options', (
    tester,
  ) async {
    final repository = FakeSessionRepository();
    await _pumpScreen(tester, repository);
    await tester.enterText(find.byType(TextField), '   ');
    await _chooseAgent(tester, 'plan');
    await _chooseAgent(tester, 'Server default');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(repository.inputs.single.toJson(), isEmpty);
  });

  testWidgets('creation error preserves input and selection and allows retry', (
    tester,
  ) async {
    final repository = FakeSessionRepository()
      ..createError = const NetworkException('offline');
    await _pumpScreen(tester, repository);
    await tester.enterText(find.byType(TextField), 'Keep my title');
    await _chooseAgent(tester, 'plan');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(find.byType(NewSessionDialog), findsOneWidget);
    expect(
      find.text('Could not create the session. Please try again.'),
      findsOneWidget,
    );
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      'Keep my title',
    );
    expect(repository.listCalls, 1);
    repository.createError = null;
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(repository.inputs, [
      const CreateSessionInput(title: 'Keep my title', agent: 'plan'),
      const CreateSessionInput(title: 'Keep my title', agent: 'plan'),
    ]);
    expect(find.byType(NewSessionDialog), findsNothing);
  });

  testWidgets(
    'loading disables edits, duplicate sends, cancel, barrier and back',
    (tester) async {
      final pending = Completer<Session>();
      final repository = FakeSessionRepository()
        ..pendingCreation = pending.future;
      await _pumpScreen(tester, repository);
      await tester.tap(find.text('Create'));
      await tester.tap(find.text('Create'));
      await tester.pump();
      expect(find.text('Creating…'), findsOneWidget);
      expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
      expect(
        tester
            .widget<DropdownButtonFormField<String>>(
              find.byType(DropdownButtonFormField<String>),
            )
            .onChanged,
        isNull,
      );
      await tester.tap(find.text('Cancel'));
      await tester.tapAt(const Offset(1, 1));
      await tester.binding.handlePopRoute();
      await tester.pump();
      expect(find.byType(NewSessionDialog), findsOneWidget);
      expect(repository.inputs, hasLength(1));
      pending.complete(createdSession);
      await tester.pumpAndSettle();
      expect(find.byType(NewSessionDialog), findsNothing);
    },
  );

  testWidgets('can create with default while agents are still loading', (
    tester,
  ) async {
    final agents = Completer<List<AgentInfo>>();
    final repository = FakeSessionRepository();
    await _pumpScreen(tester, repository, loadAgents: () => agents.future);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(repository.inputs.single.agent, isNull);
    expect(find.byType(NewSessionDialog), findsNothing);
    agents.complete(_agents);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('agent load error allows default creation', (tester) async {
    final repository = FakeSessionRepository();
    await _pumpScreen(
      tester,
      repository,
      loadAgents: () => throw const NetworkException('offline'),
    );
    expect(find.textContaining('Could not load agents'), findsOneWidget);
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(repository.inputs.single.agent, isNull);
    expect(find.byType(SessionTile), findsOneWidget);
  });

  testWidgets('agent load retry populates selector without losing title', (
    tester,
  ) async {
    var calls = 0;
    final repository = FakeSessionRepository();
    await _pumpScreen(
      tester,
      repository,
      loadAgents: () {
        if (++calls == 1) throw const NetworkException('offline');
        return _agents;
      },
    );
    await tester.enterText(find.byType(TextField), 'Keep title');
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    await _chooseAgent(tester, 'build');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(calls, 2);
    expect(
      repository.inputs.single,
      const CreateSessionInput(title: 'Keep title', agent: 'build'),
    );
  });

  testWidgets('empty agent list still supports default creation', (
    tester,
  ) async {
    final repository = FakeSessionRepository();
    await _pumpScreen(tester, repository, loadAgents: () => []);
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(repository.inputs.single.agent, isNull);
  });

  testWidgets(
    'keyboard can select an agent and submit; controls have accessible targets',
    (tester) async {
      final semantics = tester.ensureSemantics();
      try {
        final repository = FakeSessionRepository();
        await _pumpScreen(tester, repository);
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();
        expect(repository.inputs.single.agent, 'build');
        expect(find.byType(NewSessionDialog), findsNothing);
      } finally {
        semantics.dispose();
      }
    },
  );

  testWidgets('list refresh failure closes dialog without repeating POST', (
    tester,
  ) async {
    final repository = FakeSessionRepository();
    await _pumpScreen(tester, repository);
    repository.listError = const NetworkException('refresh failed');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(find.byType(NewSessionDialog), findsNothing);
    expect(find.text('Could not load sessions'), findsOneWidget);
    expect(repository.inputs, hasLength(1));
  });

  testWidgets('server change closes dialog and ignores late completion', (
    tester,
  ) async {
    final pending = Completer<Session>();
    final repository = FakeSessionRepository()
      ..pendingCreation = pending.future;
    await _pumpScreen(tester, repository);
    await tester.tap(find.text('Create'));
    await tester.pump();
    final container = ProviderScope.containerOf(
      tester.element(find.byType(NewSessionDialog)),
    );
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await tester.pumpAndSettle();
    expect(find.byType(NewSessionDialog), findsNothing);
    expect(repository.creationToken?.isCancelled, isTrue);
    pending.complete(createdSession);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(repository.listCalls, 1);
  });

  testWidgets('changing server also closes an open agent menu', (tester) async {
    final repository = FakeSessionRepository();
    await _pumpScreen(tester, repository);
    final container = ProviderScope.containerOf(
      tester.element(find.byType(NewSessionDialog)),
    );
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await tester.pumpAndSettle();
    expect(find.byType(NewSessionDialog), findsNothing);
    expect(find.text('build'), findsNothing);
    expect(repository.inputs, isEmpty);
    expect(tester.takeException(), isNull);
  });

  for (final size in [const Size(320, 568), const Size(1024, 768)]) {
    testWidgets('dialog fits $size with large text and keyboard', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repository = FakeSessionRepository();
      await _pumpScreen(tester, repository, textScale: 2, keyboardHeight: 180);
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Create'));
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();
      expect(repository.inputs, hasLength(1));
      expect(tester.takeException(), isNull);
    });
  }
}
