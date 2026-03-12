import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/markdown_renderer/markdown_renderer.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: MarkdownRenderer)
Widget defaultMarkdownRenderer(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: MarkdownRenderer(
        data: context.knobs.string(
          label: 'Markdown content',
          initialValue: '''# Hello OpenCode!

This is a demonstration of the **MarkdownRenderer** component.

## Features
- Renders markdown with terminal aesthetic
- Custom code block styling
- Selectable text
- Proper link styling

Here is a [link to Google](https://google.com).

### Code Example
And here is some Dart code:

```dart
void main() {
  print("Terminal aesthetic!");
  final numbers = [1, 2, 3];
  numbers.forEach((n) => print(n * 2));
}
```

### Inline Code
Inline `code` should look neat too with a subtle background.

> This is a blockquote that should have a left border and muted text color.

### Lists
- Item one
- Item two
  - Nested item
- Item three

1. First ordered item
2. Second ordered item
3. Third ordered item
''',
        ),
      ),
    ),
  );
}
