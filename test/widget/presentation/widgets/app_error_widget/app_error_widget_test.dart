import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';

void main() {
  group('AppErrorWidget', () {
    testWidgets('renders error icon in full mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: 'Error occurred', onRetry: () {}),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon, isNotNull);
      expect(icon.size, 48);
      expect(icon.color, AppColors.error);
    });

    testWidgets('renders message text in full mode', (tester) async {
      const testMessage = 'Something went wrong';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: testMessage, onRetry: () {}),
          ),
        ),
      );

      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('compact mode renders row layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(
              message: 'Error',
              onRetry: () {},
              compact: true,
            ),
          ),
        ),
      );

      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);
    });

    testWidgets('does not render AppButton when onRetry is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppErrorWidget(message: 'Error')),
        ),
      );

      expect(find.byType(AppButton), findsNothing);
    });

    testWidgets(
      'does not render IconButton when onRetry is null in compact mode',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppErrorWidget(message: 'Error', compact: true),
            ),
          ),
        );

        expect(find.byType(IconButton), findsNothing);
      },
    );
  });
}
