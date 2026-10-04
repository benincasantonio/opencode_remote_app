import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/core/theme/app_theme.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/agent_providers.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/router/app_router.dart';
import 'package:opencode_remote_app/presentation/screens/home/home_screen.dart';
import 'package:opencode_remote_app/presentation/screens/home/recent_sessions_widget.dart';
import 'package:opencode_remote_app/presentation/screens/home/server_status_widget.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/new_session_dialog.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/sessions_list_screen.dart';

import '../../../../support/session_test_support.dart';

Future<GoRouter> _pumpHome(
  WidgetTester tester,
  FakeSessionRepository repository, {
  double textScale = 1,
}) async {
  final router = GoRouter(
    initialLocation: homePath,
    routes: [
      GoRoute(path: homePath, builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: sessionsPath,
        builder: (_, _) => const SessionsListScreen(),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        healthPollingProvider.overrideWith((ref) => Stream.value(testHealth)),
        sessionRepositoryProvider.overrideWithValue(repository),
        sessionAgentsProvider.overrideWith((ref) async => []),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  return router;
}

void main() {
  late FakeSessionRepository repository;
  setUp(() => repository = FakeSessionRepository());

  testWidgets('shows newest five below server health in descending order', (
    tester,
  ) async {
    repository.sessions = [
      for (final i in [1, 6, 3, 5, 2, 4])
        createdSession.copyWith(
          id: 'ses_$i',
          title: 'Session $i',
          time: SessionTime(created: 0, updated: i),
        ),
    ];
    await _pumpHome(tester, repository);
    expect(find.text('Recent sessions'), findsOneWidget);
    final tiles = tester.widgetList<ListTile>(find.byType(ListTile)).toList();
    expect(tiles.map((tile) => (tile.title as Text).data), [
      'Session 6',
      'Session 5',
      'Session 4',
      'Session 3',
      'Session 2',
    ]);
    expect(find.text('Session 1'), findsNothing);
    expect(
      tester.getTopLeft(find.byType(RecentSessionsWidget)).dy,
      greaterThan(tester.getBottomLeft(find.byType(ServerStatusWidget)).dy),
    );
  });

  testWidgets('empty list keeps both actions available', (tester) async {
    await _pumpHome(tester, repository);
    expect(find.text('No sessions yet'), findsOneWidget);
    expect(find.text('New session'), findsOneWidget);
    expect(find.text('View all'), findsOneWidget);
  });

  testWidgets('uses slug when the title is blank and shows updated time', (
    tester,
  ) async {
    repository.sessions = [createdSession.copyWith(title: '  ')];
    await _pumpHome(tester, repository);
    expect(find.text(createdSession.slug), findsOneWidget);
    expect(find.textContaining('Updated '), findsOneWidget);
  });

  testWidgets('loading shows progress, then sessions', (tester) async {
    final pending = Completer<List<Session>>();
    repository.pendingSessions = pending.future;
    await _pumpHome(tester, repository);
    expect(find.bySemanticsLabel('Loading sessions'), findsOneWidget);
    expect(find.text('No sessions yet'), findsNothing);
    pending.complete([createdSession]);
    await tester.pumpAndSettle();
    expect(find.text(createdSession.title), findsOneWidget);
  });

  testWidgets('retry replaces the error without hiding server health', (
    tester,
  ) async {
    repository.listError = const NetworkException('offline');
    await _pumpHome(tester, repository);
    expect(find.text('Could not load sessions'), findsOneWidget);
    expect(find.byType(ServerStatusWidget), findsOneWidget);
    repository.listError = null;
    repository.sessions = [createdSession];
    await tester.ensureVisible(find.text('Retry'));
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text(createdSession.title), findsOneWidget);
    expect(repository.listCalls, 2);
  });

  testWidgets('View all navigates to sessions using the same loaded list', (
    tester,
  ) async {
    repository.sessions = [createdSession];
    final router = await _pumpHome(tester, repository);
    await tester.tap(find.text('View all'));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, sessionsPath);
    expect(find.byType(SessionsListScreen), findsOneWidget);
    expect(find.text(createdSession.title), findsOneWidget);
    expect(repository.listCalls, 1);
  });

  testWidgets(
    'New session opens existing dialog and refreshes recent sessions',
    (tester) async {
      await _pumpHome(tester, repository);
      await tester.tap(find.text('New session'));
      await tester.pumpAndSettle();
      expect(find.byType(NewSessionDialog), findsOneWidget);
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();
      expect(find.byType(NewSessionDialog), findsNothing);
      expect(find.text(createdSession.title), findsOneWidget);
      expect(repository.inputs, [const CreateSessionInput()]);
      expect(repository.listCalls, 2);
    },
  );

  testWidgets('deleting from full list also updates Home on return', (
    tester,
  ) async {
    repository.sessions = [createdSession];
    final router = await _pumpHome(tester, repository);
    await tester.tap(find.text('View all'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete session'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete session'));
    await tester.pumpAndSettle();
    router.pop();
    await tester.pumpAndSettle();
    expect(find.text(createdSession.title), findsNothing);
    expect(find.text('No sessions yet'), findsOneWidget);
    expect(repository.listCalls, 2);
  });

  for (final size in [const Size(320, 568), const Size(1024, 768)]) {
    testWidgets('Home fits $size with large text and long title', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      repository.sessions = [
        createdSession.copyWith(title: 'A very long session title ' * 8),
      ];
      await _pumpHome(tester, repository, textScale: 2);
      await tester.ensureVisible(find.text('View all'));
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('View all'));
      await tester.pumpAndSettle();
      expect(find.byType(SessionsListScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Home actions have accessible labels and touch targets', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await _pumpHome(tester, repository);
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    } finally {
      semantics.dispose();
    }
  });
}
