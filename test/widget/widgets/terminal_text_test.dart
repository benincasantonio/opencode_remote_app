import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/presentation/widgets/terminal_text/terminal_text.dart';

void main() {
  group('TerminalText', () {
    testWidgets('renders text', (WidgetTester tester) async {
      const testText = 'hello';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TerminalText(text: testText)),
        ),
      );

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('uses base style by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TerminalText(text: 'test')),
        ),
      );

      final textFinder = find.byType(Text);
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget(textFinder) as Text;
      final textStyle = textWidget.style;

      expect(textStyle?.fontFamily, equals('JetBrains Mono'));
      expect(textStyle?.fontSize, equals(14));
    });

    testWidgets('color override', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TerminalText(text: 'test', color: Colors.red),
          ),
        ),
      );

      final textFinder = find.byType(Text);
      final textWidget = tester.widget(textFinder) as Text;
      final textStyle = textWidget.style;

      expect(textStyle?.color, Colors.red);
    });

    testWidgets('fontSize override', (WidgetTester tester) async {
      const customFontSize = 20.0;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TerminalText(text: 'test', fontSize: customFontSize),
          ),
        ),
      );

      final textFinder = find.byType(Text);
      final textWidget = tester.widget(textFinder) as Text;
      final textStyle = textWidget.style;

      expect(textStyle?.fontSize, customFontSize);
    });

    testWidgets('style override merges', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TerminalText(
              text: 'test',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

      final textFinder = find.byType(Text);
      final textWidget = tester.widget(textFinder) as Text;
      final textStyle = textWidget.style;

      expect(textStyle?.fontWeight, FontWeight.bold);
      expect(textStyle?.fontFamily, equals('JetBrains Mono'));
    });

    testWidgets('style takes priority over color/fontSize', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TerminalText(
              text: 'test',
              color: Colors.red,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      );

      final textFinder = find.byType(Text);
      final textWidget = tester.widget(textFinder) as Text;
      final textStyle = textWidget.style;

      expect(textStyle?.color, Colors.blue);
    });

    testWidgets('maxLines and overflow', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TerminalText(
              text: 'test',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

      final textFinder = find.byType(Text);
      final textWidget = tester.widget(textFinder) as Text;

      expect(textWidget.maxLines, 1);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('selectable renders SelectableText', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TerminalText(text: 'test', selectable: true)),
        ),
      );

      expect(find.byType(SelectableText), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('selectable ignores overflow', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TerminalText(
              text: 'test',
              selectable: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

      expect(find.byType(SelectableText), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });
  });
}
