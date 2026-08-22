# P2-08: Create `AppButton` Widget — Implementation Plan

## Background

GitHub Issue [#19](https://github.com/benincasantonio/opencode_remote_app/issues/19) requests a reusable button component (`AppButton`) to be used throughout the app. It must support multiple visual variants (`primary`, `secondary`, `destructive`, `ghost`), an optional leading icon, and a loading state (`isLoading`) that disables the button and shows a spinner.

---

## Proposed Changes

### 1. Button Variant Enum

#### [NEW] `lib/presentation/widgets/app_button/app_button_variant.dart`

Define the visual variants supported by the button.

```dart
enum AppButtonVariant { primary, secondary, destructive, ghost }
```

---

### 2. Main Widget

#### [NEW] `lib/presentation/widgets/app_button/app_button.dart`

A `StatelessWidget` that wraps either an `ElevatedButton`, `OutlinedButton`, or `TextButton` depending on the selected variant, styled with `AppColors` and `AppTypography`.

**Constructor parameters:**

| Parameter   | Type               | Required | Default                    |
| ----------- | ------------------ | -------- | -------------------------- |
| `label`     | `String`           | ✅       | —                          |
| `onPressed` | `VoidCallback?`    | ✅       | —                          |
| `variant`   | `AppButtonVariant` | ❌       | `AppButtonVariant.primary` |
| `isLoading` | `bool`             | ❌       | `false`                    |
| `icon`      | `IconData?`        | ❌       | `null`                     |

**Styling & Behavior:**

- When `isLoading == true` or `onPressed == null`, the button is disabled (pass `null` to the underlying button's `onPressed`).
- When `isLoading == true`, a small `SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))` is shown next to or instead of the icon.

**Variant Mapping:**

| Variant       | Button Type      | Background Color         | Foreground Color (Text/Icon) | Border                         |
| ------------- | ---------------- | ------------------------ | ---------------------------- | ------------------------------ |
| `primary`     | `FilledButton`   | `AppColors.primaryGreen` | Colors.white                 | None                           |
| `secondary`   | `OutlinedButton` | Transparent              | `AppColors.textPrimary`      | `BorderSide(AppColors.border)` |
| `destructive` | `FilledButton`   | `AppColors.error`        | Colors.white                 | None                           |
| `ghost`       | `TextButton`     | Transparent              | `AppColors.accentCyan`       | None                           |

**Implementation Skeleton:**

```dart
import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'app_button_variant.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    // 1. Determine active state
    final isDisabled = isLoading || onPressed == null;
    final effectiveOnPressed = isDisabled ? null : onPressed;

    // 2. Build the inner content (Icon/Spinner + Label)
    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white), // color depends on variant
          ),
          const SizedBox(width: AppSizing.gapSmall),
        ] else if (icon != null) ...[
          Icon(icon, size: AppSizing.iconSmall),
          const SizedBox(width: AppSizing.gapSmall),
        ],
        Text(label, style: AppTypography.label), // Note: use appropriate style
      ],
    );

    // 3. Wrap in correct Material button based on variant
    switch (variant) {
      case AppButtonVariant.primary:
        return FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizing.radiusSmall)),
          ),
          child: child,
        );
      case AppButtonVariant.secondary:
        return OutlinedButton( ... );
      case AppButtonVariant.destructive:
        return FilledButton( ... );
      case AppButtonVariant.ghost:
        return TextButton( ... );
    }
  }
}
```

_Note: The actual implementation will abstract the styling logic or use `ButtonStyle` overlays carefully to ensure disabled states (when `isLoading` is true) still maintain readable contrast but look disabled._

---

### 3. Widgetbook Use-Case

#### [NEW] `widgetbook/lib/app_button_use_case.dart`

Create a Widgetbook use-case to interactively test all variants, standard/loading states, and icons.

```dart
import 'package:flutter/material.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button_variant.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppButton)
Widget defaultAppButton(BuildContext context) {
  final showIcon = context.knobs.boolean(label: 'Show Icon', initialValue: false);

  return Center(
    child: AppButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Click Me'),
      variant: context.knobs.list<AppButtonVariant>(
        label: 'Variant',
        options: AppButtonVariant.values,
        initialOption: AppButtonVariant.primary,
        labelBuilder: (v) => v.name,
      ),
      isLoading: context.knobs.boolean(label: 'Is Loading', initialValue: false),
      icon: showIcon ? Icons.send : null,
      onPressed: () {}, // Provide a dummy callback so it isn't completely disabled
    ),
  );
}
```

_Note: Run `dart run build_runner build --delete-conflicting-outputs` in the `widgetbook` directory after creating._

---

### 4. Widget Tests

#### [NEW] `test/widget/presentation/widgets/app_button_test.dart`

Ensure the button renders correctly and handles interactions and states.

| Test Case                                        | Assertion                                                                   |
| ------------------------------------------------ | --------------------------------------------------------------------------- |
| Renders label text                               | `find.text('My Button')` finds one widget.                                  |
| Triggers `onPressed` when tapped                 | Mock function is called once after `tester.tap()`.                          |
| Shows loading indicator when `isLoading` is true | `find.byType(CircularProgressIndicator)` finds one widget.                  |
| Disables button when `isLoading` is true         | Tapping the button does _not_ trigger the `onPressed` callback.             |
| Renders icon when provided                       | `find.byIcon(Icons.add)` finds one widget.                                  |
| Disables button when `onPressed` is null         | Button state is disabled (can verify via visual semantics or tap ignoring). |

---

## File Summary

| Action  | File                                                          | Purpose                 |
| ------- | ------------------------------------------------------------- | ----------------------- |
| **NEW** | `lib/presentation/widgets/app_button/app_button_variant.dart` | Variant enum definition |
| **NEW** | `lib/presentation/widgets/app_button/app_button.dart`         | Main widget             |
| **NEW** | `widgetbook/lib/app_button_use_case.dart`                     | Widgetbook integration  |
| **NEW** | `test/widget/presentation/widgets/app_button_test.dart`       | Widget tests            |

---

## Verification Plan

### Automated Tests

```bash
flutter test test/widget/presentation/widgets/app_button_test.dart
flutter analyze lib/presentation/widgets/app_button/
```

### Visual Testing

```bash
cd widgetbook
dart run build_runner build --delete-conflicting-outputs
flutter run -d macos
```

- Open Widgetbook and test the `AppButton`.
- Cycle through all four **Variants** to ensure correct colors.
- Toggle **Is Loading** to verify the spinner appears and the button visually darkens/disables.
- Toggle **Show Icon** to verify proper spacing between the icon and text.
