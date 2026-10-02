import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_status_badge.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_tile.dart';

import '../../../../helpers/pump_with_l10n.dart';

void main() {
  group('SessionTile', () {
    final now = DateTime.now().millisecondsSinceEpoch;

    final sampleSession = Session(
      id: 'ses_1',
      slug: 'swift-falcon',
      projectID: 'global',
      directory: '/Users/test/project',
      title: 'Fix issue with database connection',
      version: '1.0.0',
      time: SessionTime(created: now - 100000, updated: now - 60000),
    );

    testWidgets(
      'renders title, directory with slug, relative time, and badge',
      (tester) async {
        await pumpWidgetWithL10n(
          tester,
          Scaffold(
            body: SessionTile(
              session: sampleSession,
              status: const SessionStatus.idle(),
            ),
          ),
        );

        expect(find.text('Fix issue with database connection'), findsOneWidget);
        expect(find.text('swift-falcon · /Users/test/project'), findsOneWidget);
        expect(find.textContaining('Updated'), findsOneWidget);
        expect(find.byType(SessionStatusBadge), findsOneWidget);
        expect(find.text('Idle'), findsOneWidget);
      },
    );

    testWidgets('falls back to slug when title is empty', (tester) async {
      final sessionWithoutTitle = sampleSession.copyWith(title: '');

      await pumpWidgetWithL10n(
        tester,
        Scaffold(body: SessionTile(session: sessionWithoutTitle)),
      );

      expect(find.text('swift-falcon'), findsOneWidget);
      expect(find.text('/Users/test/project'), findsOneWidget);
    });

    testWidgets('triggers onTap when tapped', (tester) async {
      var tapped = false;

      await pumpWidgetWithL10n(
        tester,
        Scaffold(
          body: SessionTile(session: sampleSession, onTap: () => tapped = true),
        ),
      );

      await tester.tap(find.byType(SessionTile));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('displays busy status badge when provided', (tester) async {
      await pumpWidgetWithL10n(
        tester,
        Scaffold(
          body: SessionTile(
            session: sampleSession,
            status: const SessionStatus.busy(),
          ),
        ),
      );

      expect(find.text('Busy'), findsOneWidget);
    });
  });
}
