import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_badge.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

void main() {
  group('ConnectionBadge', () {
    group('label and dot color', () {
      testWidgets(
        'renders "Connected" label with green dot for connected status',
        (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: ConnectionBadge(status: ConnectionStatus.connected),
              ),
            ),
          );

          expect(find.text('Connected'), findsOneWidget);

          final container = tester.widget<Container>(
            find.byType(Container).first,
          );
          final decoration = container.decoration as BoxDecoration?;
          expect(decoration?.color, AppColors.success);
        },
      );

      testWidgets(
        'renders "Connecting…" label with warning dot for connecting status',
        (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: ConnectionBadge(status: ConnectionStatus.connecting),
              ),
            ),
          );

          expect(find.text('Connecting…'), findsOneWidget);

          final container = tester.widget<Container>(
            find.byType(Container).first,
          );
          final decoration = container.decoration as BoxDecoration?;
          expect(decoration?.color, AppColors.warning);
        },
      );

      testWidgets(
        'renders "Disconnected" label with muted dot for disconnected status',
        (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: ConnectionBadge(status: ConnectionStatus.disconnected),
              ),
            ),
          );

          expect(find.text('Disconnected'), findsOneWidget);

          final container = tester.widget<Container>(
            find.byType(Container).first,
          );
          final decoration = container.decoration as BoxDecoration?;
          expect(decoration?.color, AppColors.textMuted);
        },
      );

      testWidgets('renders "Error" label with red dot for error status', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.error),
            ),
          ),
        );

        expect(find.text('Error'), findsOneWidget);

        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        final decoration = container.decoration as BoxDecoration?;
        expect(decoration?.color, AppColors.error);
      });
    });

    group('server name', () {
      testWidgets('shows server name when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(
                status: ConnectionStatus.connected,
                serverName: 'my-server',
              ),
            ),
          ),
        );

        expect(find.text('my-server'), findsOneWidget);
        expect(find.text('·'), findsOneWidget);
      });

      testWidgets('hides server name when null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(
                status: ConnectionStatus.connected,
                serverName: null,
              ),
            ),
          ),
        );

        expect(find.text('my-server'), findsNothing);
        expect(find.text('·'), findsNothing);
      });
    });

    group('pulse animation', () {
      testWidgets('renders without crashing in connecting state', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.connecting),
            ),
          ),
        );

        expect(find.byType(ConnectionBadge), findsOneWidget);
        expect(find.text('Connecting…'), findsOneWidget);
      });

      testWidgets('can pump through animation cycles', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.connecting),
            ),
          ),
        );

        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 250));
        }

        expect(find.byType(ConnectionBadge), findsOneWidget);
      });

      testWidgets('status changes between states without errors', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.connected),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Connected'), findsOneWidget);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.connecting),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Connecting…'), findsOneWidget);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.error),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Error'), findsOneWidget);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ConnectionBadge(status: ConnectionStatus.disconnected),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Disconnected'), findsOneWidget);
      });
    });
  });
}
