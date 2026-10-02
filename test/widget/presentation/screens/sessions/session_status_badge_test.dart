import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/data/models/session.dart';
import 'package:opencode_remote_app/presentation/screens/sessions/session_status_badge.dart';

import '../../../../helpers/pump_with_l10n.dart';

void main() {
  group('SessionStatusBadge', () {
    testWidgets('renders idle status badge', (tester) async {
      await pumpWidgetWithL10n(
        tester,
        const Scaffold(body: SessionStatusBadge(status: SessionStatus.idle())),
      );

      expect(find.text('Idle'), findsOneWidget);
    });

    testWidgets('renders busy status badge with animation', (tester) async {
      await pumpWidgetWithL10n(
        tester,
        const Scaffold(body: SessionStatusBadge(status: SessionStatus.busy())),
      );

      expect(find.text('Busy'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(SessionStatusBadge),
          matching: find.byType(FadeTransition),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders retry status badge', (tester) async {
      await pumpWidgetWithL10n(
        tester,
        const Scaffold(
          body: SessionStatusBadge(
            status: SessionStatus.retry(
              attempt: 1,
              message: 'Rate limit',
              next: 3000,
            ),
          ),
        ),
      );

      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('updates animation when status changes from idle to busy', (
      tester,
    ) async {
      await pumpWidgetWithL10n(
        tester,
        const Scaffold(body: SessionStatusBadge(status: SessionStatus.idle())),
      );

      expect(
        find.descendant(
          of: find.byType(SessionStatusBadge),
          matching: find.byType(FadeTransition),
        ),
        findsNothing,
      );

      await pumpWidgetWithL10n(
        tester,
        const Scaffold(body: SessionStatusBadge(status: SessionStatus.busy())),
      );

      expect(
        find.descendant(
          of: find.byType(SessionStatusBadge),
          matching: find.byType(FadeTransition),
        ),
        findsOneWidget,
      );
    });
  });
}
