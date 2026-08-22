# P2-06: Create `MarkdownRenderer` Widget — Implementation Plan

## Background

GitHub Issue [#17](https://github.com/benincasantonio/opencode_remote_app/issues/17) requests a custom markdown rendering component. Since AI responses from the OpenCode server will often include markdown formatting (especially code blocks and links), this component will wrap the `flutter_markdown` package, adapt it to the project's terminal aesthetic (using `AppColors` and `AppTypography`), and delegate code block rendering to the existing `CodeBlock` widget.

---

## Proposed Changes

### 1. Markdown Renderer Widget

#### [NEW] `lib/presentation/widgets/markdown_renderer/markdown_renderer.dart`

A `StatelessWidget` that wraps `MarkdownBody` or `Markdown` from `flutter_markdown`.

**Constructor parameters:**

| Parameter | Type     | Required | Default |
| --------- | -------- | -------- | ------- |
| `data`    | `String` | ✅       | —       |

**Styling details (`MarkdownStyleSheet`):**

- **p:** `AppTypography.bodyMedium` (or `bodyLarge`) with `AppColors.textPrimary`.
- **a (links):** `color: AppColors.accentCyan`, with optionally an underline text decoration.
- **h1..h6:** Utilize the various headline styles from `AppTypography`.
- **code (inline):** Use `AppTypography.codeSmall` with a slightly translucent or distinct background (e.g., `AppColors.surfaceVariant`) to make inline code pop.
- **blockquote:** Indented and styled with `AppColors.textMuted` and optionally a left border.

**Behavior:**

- Use `MarkdownBody` (with `selectable: true`) rather than `Markdown` so it can be placed securely inside lists (e.g., chat bubbles).
- The user can select text from the markdown document.

---

### 2. Code Block Integration

`flutter_markdown` handles blocks of code natively, but we need to intercept them and render our custom `CodeBlock` widget instead of the default container.

To do this, we create a custom `MarkdownElementBuilder`.

#### [NEW] `lib/presentation/widgets/markdown_renderer/markdown_code_builder.dart` (or inside the same file)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:opencode_remote_app/presentation/widgets/code_block/code_block.dart';

class MarkdownCodeBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // If this is block code (pre > code), `textContent` gives the exact code
    // The language class is usually attached to the `code` element (e.g., 'class': 'language-dart')

    final codeText = element.textContent;

    // Extract language: flutter_markdown parses classes like 'language-dart'
    String matchedLang = 'TEXT';
    final classNames = element.attributes['class'];
    if (classNames != null) {
      final langClass = classNames.split(' ').firstWhere((c) => c.startsWith('language-'), orElse: () => '');
      if (langClass.isNotEmpty) {
        matchedLang = langClass.substring(9).toUpperCase(); // remove 'language-'
      }
    }

    // Attempt to map matchedLang to `flutter_syntax_view`'s Syntax enum
    final syntax = Syntax.values.cast<Syntax?>().firstWhere(
      (s) => s?.name.toUpperCase() == matchedLang,
      orElse: () => Syntax.DART, // Default fallback
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // Delegate to the existing CodeBlock implementation
      child: CodeBlock(
        code: codeText.trimRight(),
        language: syntax ?? Syntax.DART,
        showLineNumbers: true,
      ),
    );
  }
}
```

Then in `MarkdownRenderer`, provide this builder:

```dart
@override
Widget build(BuildContext context) {
  return MarkdownBody(
    data: data,
    selectable: true,
    styleSheet: MarkdownStyleSheet(
      // ... typography and colors ...
      a: AppTypography.bodyMedium.copyWith(color: AppColors.accentCyan, decoration: TextDecoration.underline),
      p: AppTypography.bodyMedium,
      // ...
    ),
    builders: {
      'code': MarkdownCodeBuilder(),
    },
    // IMPORTANT: To ensure inline `code` isn't replaced by our builder (which returns a large block),
    // you might need to target the styling carefully or check if `element.textContent` contains newlines,
    // depending on how flutter_markdown handles `pre` vs `code`.
  );
}
```

_Note on flutter_markdown constraints: If `code` builder intercepts both inline and block code, logic must differentiate them (e.g., if `element.attributes.containsKey('class')` typically means block code, or check if parent is `pre`)._

---

### 3. Widgetbook Use-Case

#### [NEW] `widgetbook/lib/markdown_renderer_use_case.dart`

````dart
import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/markdown_renderer/markdown_renderer.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: MarkdownRenderer)
Widget defaultMarkdownRenderer(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: MarkdownRenderer(
      data: context.knobs.string(
        label: 'Markdown content',
        initialValue: '''
# Hello OpenCode!
This is a demonstration of the **MarkdownRenderer**.

Here is a [link to Google](https://google.com).

And here is some dart code:
```dart
void main() {
  print("Terminal aesthetic!");
}
````

Inline `code` should look neat too.
''',
),
),
);
}

````

---

### 4. Widget Tests

#### [NEW] `test/widget/presentation/widgets/markdown_renderer_test.dart`

| Test Case | Assertion |
| --- | --- |
| Renders multiple markdown parts | Given data with text, links, and code, `find.byType(RichText)` finds elements. |
| Delegates to `CodeBlock` widget for block code | `find.byType(CodeBlock)` finds the widget when fenced code blocks `\`\`\`` are provided. |
| Uses `AppColors.accentCyan` for links | Extract the rendered rich text for the link and verify the `TextStyle.color`. |
| Supports selectable body | Verify `SelectableText.rich` (or equivalent selectable variant) is used by reading the widget tree. |

---

## File Summary

| Action | File | Purpose |
| --- | --- | --- |
| **NEW** | `lib/presentation/widgets/markdown_renderer/markdown_code_builder.dart` | Custom `MarkdownElementBuilder` for code blocks |
| **NEW** | `lib/presentation/widgets/markdown_renderer/markdown_renderer.dart` | Main widget |
| **NEW** | `widgetbook/lib/markdown_renderer_use_case.dart` | Widgetbook integration |
| **NEW** | `test/widget/presentation/widgets/markdown_renderer_test.dart` | Widget tests |

---

## Verification Plan

### Automated Tests
```bash
flutter test test/widget/presentation/widgets/markdown_renderer_test.dart
flutter analyze lib/presentation/widgets/markdown_renderer/
````

### Visual Testing

```bash
cd widgetbook
dart run build_runner build --delete-conflicting-outputs
flutter run -d macos
```

- Open Widgetbook and test `MarkdownRenderer`.
- Ensure headers, paragraphs, and lists look distinct and match the terminal theme.
- Ensure the `CodeBlock` component is rendering the fenced Dart block properly.
- Try selecting the text to verify `selectable: true` is functioning.
