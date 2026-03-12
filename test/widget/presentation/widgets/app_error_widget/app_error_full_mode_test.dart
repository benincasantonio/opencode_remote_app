import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';

void main() {
  group('AppErrorFullMode', () {
    testWidgets('renders AppButton for retry', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: 'Error', onRetry: () {}),
          ),
        ),
      );

      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('retry button has correct label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: 'Error', onRetry: () {}),
          ),
        ),
      );

      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('triggers onRetry callback when retry button is tapped', (
      tester,
    ) async {
      bool onRetryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(
              message: 'Error',
              onRetry: () => onRetryCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(onRetryCalled, isTrue);
    });

    testWidgets('full mode has correct background color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: 'Error', onRetry: () {}),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byIcon(Icons.error_outline),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.color, AppColors.surfaceVariant);
    });

    testWidgets('full mode has correct padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: 'Error', onRetry: () {}),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byIcon(Icons.error_outline),
          matching: find.byType(Container),
        ),
      );

      expect(container.padding, const EdgeInsets.all(AppSizing.gapXXLarge));
    });
  });
}
