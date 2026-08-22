import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/widgets/app_error_widget/app_error_widget.dart';

void main() {
  group('AppErrorCompactMode', () {
    testWidgets('compact mode renders smaller error icon', (tester) async {
      await tester.pumpWidget(
        _TestApp(
          child: AppErrorWidget(
            message: 'Error',
            onRetry: () {},
            compact: true,
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon, isNotNull);
      expect(icon.size, 20);
    });

    testWidgets('compact mode uses IconButton for retry', (tester) async {
      await tester.pumpWidget(
        _TestApp(
          child: AppErrorWidget(
            message: 'Error',
            onRetry: () {},
            compact: true,
          ),
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('compact mode triggers onRetry callback', (tester) async {
      bool onRetryCalled = false;

      await tester.pumpWidget(
        _TestApp(
          child: AppErrorWidget(
            message: 'Error',
            onRetry: () => onRetryCalled = true,
            compact: true,
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(onRetryCalled, isTrue);
    });

    testWidgets('compact retry control is at least 48x48 logical pixels', (
      tester,
    ) async {
      await tester.pumpWidget(
        _TestApp(
          child: AppErrorWidget(
            message: 'Error',
            onRetry: () {},
            compact: true,
          ),
        ),
      );

      final size = tester.getSize(find.byType(IconButton));
      expect(size.width, greaterThanOrEqualTo(48));
      expect(size.height, greaterThanOrEqualTo(48));
    });

    testWidgets('retry retains its localized accessible tooltip', (
      tester,
    ) async {
      await tester.pumpWidget(
        _TestApp(
          child: AppErrorWidget(
            message: 'Error',
            onRetry: () {},
            compact: true,
          ),
        ),
      );

      expect(find.byTooltip('Retry'), findsOneWidget);
    });
  });

  group('AppErrorWidget semantics', () {
    testWidgets('dynamic error content is announced as a live region', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const _TestApp(child: AppErrorWidget(message: 'Error', compact: true)),
      );

      final semantics = tester.getSemantics(find.byType(AppErrorWidget));
      expect(semantics, isSemantics(isLiveRegion: true));
      handle.dispose();
    });

    testWidgets('full mode still renders and fires retry', (tester) async {
      bool retried = false;

      await tester.pumpWidget(
        _TestApp(
          child: AppErrorWidget(
            message: 'Full error',
            onRetry: () => retried = true,
          ),
        ),
      );

      expect(find.text('Full error'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pump();
      expect(retried, isTrue);
    });
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }
}
