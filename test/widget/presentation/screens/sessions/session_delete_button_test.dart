import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/app_exception.dart';
import 'package:opencode_remote_app/core/theme/app_theme.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_tile.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/sessions_list_screen.dart';

import '../../../../support/session_test_support.dart';

Future<ProviderContainer> _pumpScreen(
  WidgetTester tester,
  FakeSessionRepository repository,
) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        connectionProvider.overrideWith(TestConnection.new),
        healthPollingProvider.overrideWith((ref) => Stream.value(testHealth)),
        sessionRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SessionsListScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(
    tester.element(find.byType(SessionsListScreen)),
  );
}

Future<void> _confirm(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Delete session'));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, 'Delete session'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  late FakeSessionRepository repository;
  setUp(
    () => repository = FakeSessionRepository()..sessions = [createdSession],
  );

  testWidgets('confirmation identifies session and cancel preserves it', (
    tester,
  ) async {
    await _pumpScreen(tester, repository);
    await tester.tap(find.byTooltip('Delete session'));
    await tester.pumpAndSettle();
    expect(
      find.text('Delete “New session title”? This cannot be undone.'),
      findsOneWidget,
    );
    expect(repository.deletedIds, isEmpty);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(SessionTile), findsOneWidget);
    expect(repository.deletedIds, isEmpty);
  });

  testWidgets('confirmation removes session and shows feedback', (
    tester,
  ) async {
    await _pumpScreen(tester, repository);
    await _confirm(tester);
    await tester.pumpAndSettle();
    expect(repository.deletedIds, [createdSession.id]);
    expect(find.byType(SessionTile), findsNothing);
    expect(find.text('Session deleted'), findsOneWidget);
  });

  testWidgets('error preserves row and allows retry', (tester) async {
    repository.deleteError = const NetworkException('offline');
    await _pumpScreen(tester, repository);
    await _confirm(tester);
    await tester.pumpAndSettle();
    expect(find.byType(SessionTile), findsOneWidget);
    expect(find.textContaining('Could not delete'), findsOneWidget);
    repository.deleteError = null;
    await _confirm(tester);
    await tester.pumpAndSettle();
    expect(find.byType(SessionTile), findsNothing);
    expect(repository.deletedIds, hasLength(2));
  });

  testWidgets('pending request keeps row and disables repeated deletion', (
    tester,
  ) async {
    final pending = Completer<void>();
    repository.pendingDeletion = pending.future;
    await _pumpScreen(tester, repository);
    await _confirm(tester);
    expect(find.byType(SessionTile), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(
            find.ancestor(
              of: find.byTooltip('Delete session'),
              matching: find.byType(IconButton),
            ),
          )
          .onPressed,
      isNull,
    );
    pending.complete();
    await tester.pumpAndSettle();
    expect(repository.deletedIds, hasLength(1));
  });

  testWidgets('changing server while confirming never deletes', (tester) async {
    final container = await _pumpScreen(tester, repository);
    await tester.tap(find.byTooltip('Delete session'));
    await tester.pumpAndSettle();
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete session'));
    await tester.pumpAndSettle();
    expect(repository.deletedIds, isEmpty);
  });

  testWidgets('changing server during deletion suppresses stale feedback', (
    tester,
  ) async {
    final pending = Completer<void>();
    repository.pendingDeletion = pending.future;
    final container = await _pumpScreen(tester, repository);
    await _confirm(tester);
    (container.read(connectionProvider.notifier) as TestConnection)
        .changeServer();
    await tester.pumpAndSettle();
    pending.complete();
    await tester.pumpAndSettle();
    expect(find.text('Session deleted'), findsNothing);
    expect(find.textContaining('Could not delete'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('delete controls have accessible labels and touch targets', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await _pumpScreen(tester, repository);
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await tester.tap(find.byTooltip('Delete session'));
      await tester.pumpAndSettle();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    } finally {
      semantics.dispose();
    }
  });
}
