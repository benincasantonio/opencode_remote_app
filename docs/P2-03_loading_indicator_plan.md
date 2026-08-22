# P2-03: Create `LoadingIndicator` Widget — Implementation Plan

## Background

GitHub Issue [#14](https://github.com/benincasantonio/opencode_remote_app/issues/14) requests a reusable, terminal-styled loading indicator widget. It must support two size variants (`small` and `large`), with the `large` variant optionally displaying a message below the spinner. It will be used throughout the app for async operations (e.g., initial load, network requests).

---

## Proposed Changes

### 1. Size Variant Enum

#### [NEW] `lib/presentation/widgets/loading_indicator/loading_indicator_size.dart`

An enum to define the supported sizes.

```dart
enum LoadingIndicatorSize { small, large }
```

---

### 2. Main Widget

#### [NEW] `lib/presentation/widgets/loading_indicator/loading_indicator.dart`

A `StatelessWidget` that renders a `CircularProgressIndicator` styled with the app's primary theme.

**Constructor parameters:**

| Parameter | Type                   | Required | Default                      |
| --------- | ---------------------- | -------- | ---------------------------- |
| `size`    | `LoadingIndicatorSize` | ❌       | `LoadingIndicatorSize.large` |
| `message` | `String?`              | ❌       | `null`                       |

**Implementation Details:**

- **Small Variant:** Renders just the `CircularProgressIndicator`. To constrain its size properly, it should be wrapped in a `SizedBox` with a fixed dimension (e.g., 20x20 or 24x24) and likely smaller `strokeWidth`.
- **Large Variant:** Renders a larger `CircularProgressIndicator` (default size, or slightly constrained like 40x40). If `message` is not null, it displays the message text below the spinner using `AppTypography.bodyMedium` or `AppTypography.label` and `AppColors.textMuted` (or primary).
- **Styling:** The `CircularProgressIndicator` uses `AppColors.primaryGreen` for its value color.

**Skeleton code:**

```dart
import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator_size.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.size = LoadingIndicatorSize.large,
    this.message,
  });

  final LoadingIndicatorSize size;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final isSmall = size == LoadingIndicatorSize.small;
    final spinnerSize = isSmall ? 20.0 : 40.0;
    final strokeWidth = isSmall ? 2.0 : 4.0;

    final spinner = SizedBox(
      width: spinnerSize,
      height: spinnerSize,
      child: CircularProgressIndicator(
        color: AppColors.primaryGreen,
        strokeWidth: strokeWidth,
      ),
    );

    if (isSmall || message == null) {
      return spinner;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        spinner,
        const SizedBox(height: AppSizing.gapMedium),
        Text(
          message!,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
```

---

### 3. Widgetbook Use-Case

#### [NEW] `widgetbook/lib/loading_indicator_use_case.dart`

Create a use-case for Widgetbook that enables interactive testing of the sizes and the optional message.

```dart
import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator.dart';
import 'package:opencode_remote_app/presentation/widgets/loading_indicator/loading_indicator_size.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: LoadingIndicator)
Widget defaultLoadingIndicator(BuildContext context) {
  return Center(
    child: LoadingIndicator(
      size: context.knobs.list(
        label: 'Size',
        options: LoadingIndicatorSize.values,
        initialOption: LoadingIndicatorSize.large,
        labelBuilder: (s) => s.name,
      ),
      message: context.knobs.stringOrNull(
        label: 'Message',
        initialValue: 'Loading sessions...',
      ),
    ),
  );
}
```

_Note: After writing this file, `main.directories.g.dart` in the `widgetbook` folder must be regenerated via `build_runner`._

---

### 4. Widget Tests

#### [NEW] `test/widget/presentation/widgets/loading_indicator_test.dart`

Ensure the widget behaves correctly under different configurations.

| Test Case                                    | Assertion                                                                                            |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Renders `CircularProgressIndicator`          | A `CircularProgressIndicator` widget is found in the tree.                                           |
| Large variant with message renders text      | `find.text('message')` finds one widget.                                                             |
| Large variant without message hides text     | `find.text('message')` finds zero widgets.                                                           |
| Small variant hides message even if provided | `find.text('message')` finds zero widgets when `size == small`.                                      |
| verify primary green color                   | Extract the `CircularProgressIndicator` and verify its `color` property is `AppColors.primaryGreen`. |

---

## File Summary

| Action  | File                                                                     | Purpose                |
| ------- | ------------------------------------------------------------------------ | ---------------------- |
| **NEW** | `lib/presentation/widgets/loading_indicator/loading_indicator_size.dart` | Size enum definition   |
| **NEW** | `lib/presentation/widgets/loading_indicator/loading_indicator.dart`      | Main widget            |
| **NEW** | `widgetbook/lib/loading_indicator_use_case.dart`                         | Widgetbook integration |
| **NEW** | `test/widget/presentation/widgets/loading_indicator_test.dart`           | Widget tests           |

---

## Verification Plan

### Automated Tests

```bash
flutter test test/widget/presentation/widgets/loading_indicator_test.dart
flutter analyze lib/presentation/widgets/loading_indicator/
```

### Visual Testing

```bash
cd widgetbook
dart run build_runner build --delete-conflicting-outputs
flutter run -d macos
```

- Open Widgetbook and test the `LoadingIndicator` component.
- Toggle the **Size** knob between `large` and `small`.
- Toggle the **Message** knob on and off to verify it appears (in large mode) and vanishes (in small mode or when cleared).
