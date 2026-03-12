import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block.dart';
import 'package:opencode_remote_app/presentation/widgets/markdown_renderer/markdown_renderer.dart';

void main() {
  group('MarkdownRenderer', () {
    testWidgets('renders multiple markdown parts', (tester) async {
      const markdownData = '''
# Heading
This is **bold** text.

```dart
void main() {}
```
''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('delegates to CodeBlock widget for block code', (tester) async {
      const markdownData = '''```dart
void main() {
  print("Hello");
}
```''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.byType(CodeBlock), findsOneWidget);
    });

    testWidgets('renders link text', (tester) async {
      const markdownData = '[Link](https://example.com)';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('Link'), findsOneWidget);
    });

    testWidgets('renders heading with correct style', (tester) async {
      const markdownData = '# Heading 1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('Heading 1'), findsOneWidget);
    });

    testWidgets('renders inline code', (tester) async {
      const markdownData = 'This has `inline code` here';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('This has '), findsOneWidget);
      expect(find.text('inline code'), findsOneWidget);
      expect(find.text(' here'), findsOneWidget);
    });

    testWidgets('renders blockquote', (tester) async {
      const markdownData = '> This is a blockquote';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('This is a blockquote'), findsOneWidget);
    });

    testWidgets('renders unordered list', (tester) async {
      const markdownData = '''- Item 1
- Item 2
- Item 3''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('renders ordered list', (tester) async {
      const markdownData = '''1. First
2. Second
3. Third''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
    });

    testWidgets('renders bold and italic text', (tester) async {
      const markdownData = '**Bold** and *italic* text';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('Bold and italic text'), findsOneWidget);
    });

    testWidgets('renders paragraph with multiple lines', (tester) async {
      const markdownData = '''First paragraph.

Second paragraph.''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MarkdownRenderer(data: markdownData)),
        ),
      );

      expect(find.text('First paragraph.'), findsOneWidget);
      expect(find.text('Second paragraph.'), findsOneWidget);
    });
  });
}
