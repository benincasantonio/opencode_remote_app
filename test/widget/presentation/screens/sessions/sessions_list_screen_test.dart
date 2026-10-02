import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/domain/providers/session_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_tile.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/sessions_empty_view.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/sessions_list_screen.dart';
import 'package:opencode_remote_app/presentation/widgets/app_bar/terminal_app_bar.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator.dart';

void main() {
  const healthy = ServerHealth(healthy: true, version: '1.0.0');

  AppConnectionState connectedState() {
    return const AppConnectionState(
      status: ConnectionStatus.connected,
      baseUrl: 'http://127.0.0.1:4096',
      displayName: '127.0.0.1:4096',
      health: healthy,
    );
  }

  final sampleSessions = [
    const Session(
      id: 'ses_1',
      slug: 'quick-canyon',
      projectID: 'global',
      directory: '/Users/test',
      title: 'First session',
      version: '1.0.0',
      time: SessionTime(created: 1000, updated: 2000),
    ),
    const Session(
      id: 'ses_2',
      slug: 'eager-panda',
      projectID: 'global',
      directory: '/Users/test',
      title: 'Second session',
      version: '1.0.0',
      time: SessionTime(created: 1000, updated: 1500),
    ),
  ];

  Future<void> pumpSessionsList(
    WidgetTester tester, {
    required AsyncValue<List<Session>> sessionsState,
    AsyncValue<Map<String, SessionStatus>> statusesState =
        const AsyncValue.data({}),
    Future<void> Function()? onRefresh,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectionProvider.overrideWithValue(connectedState()),
          healthPollingProvider.overrideWith((ref) => Stream.value(healthy)),
          sessionsListProvider.overrideWith((ref) {
            return sessionsState.when(
              data: (data) => Future.value(data),
              loading: () => Completer<List<Session>>().future,
              error: (err, st) => Future.error(err, st),
            );
          }),
          sessionStatusesProvider.overrideWith((ref) {
            return statusesState.when(
              data: (data) => Future.value(data),
              loading: () => Completer<Map<String, SessionStatus>>().future,
              error: (err, st) => Future.error(err, st),
            );
          }),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SessionsListScreen(),
        ),
      ),
    );
  }

  group('SessionsListScreen', () {
    testWidgets('renders TerminalAppBar with title and connected status', (
      tester,
    ) async {
      await pumpSessionsList(
        tester,
        sessionsState: AsyncValue.data(sampleSessions),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TerminalAppBar), findsOneWidget);
      expect(find.text('Sessions'), findsOneWidget);
    });

    testWidgets('shows LoadingIndicator while sessions are loading', (
      tester,
    ) async {
      await pumpSessionsList(tester, sessionsState: const AsyncValue.loading());
      await tester.pump();

      expect(find.byType(LoadingIndicator), findsOneWidget);
      expect(find.byType(SessionTile), findsNothing);
    });

    testWidgets('renders list of SessionTile when data arrives', (
      tester,
    ) async {
      await pumpSessionsList(
        tester,
        sessionsState: AsyncValue.data(sampleSessions),
        statusesState: const AsyncValue.data({'ses_1': SessionStatus.busy()}),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SessionTile), findsNWidgets(2));
      expect(find.text('First session'), findsOneWidget);
      expect(find.text('Second session'), findsOneWidget);
      expect(find.text('Busy'), findsOneWidget);
      expect(find.text('Idle'), findsOneWidget);
    });

    testWidgets('renders SessionsEmptyView when sessions list is empty', (
      tester,
    ) async {
      await pumpSessionsList(tester, sessionsState: const AsyncValue.data([]));
      await tester.pumpAndSettle();

      expect(find.byType(SessionsEmptyView), findsOneWidget);
      expect(find.text('No sessions yet'), findsOneWidget);
      expect(find.text('Pull down to refresh or check server'), findsOneWidget);
    });

    testWidgets('renders AppErrorWidget when fetching sessions fails', (
      tester,
    ) async {
      await pumpSessionsList(
        tester,
        sessionsState: AsyncValue.error(
          const NetworkException('Server unreachable'),
          StackTrace.empty,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppErrorWidget), findsOneWidget);
      expect(find.text('Could not load sessions'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('pull-to-refresh triggers refresh indicator', (tester) async {
      await pumpSessionsList(
        tester,
        sessionsState: AsyncValue.data(sampleSessions),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(RefreshIndicator), findsOneWidget);

      await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}
