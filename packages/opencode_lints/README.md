# opencode_lints

Custom lint rules for the OpenCode Remote App, built with
[`custom_lint`](https://pub.dev/packages/custom_lint).

## Rules

| Rule | Severity | Description |
|---|---|---|
| `file_size_signal` | warning | Signals when a `lib/` file exceeds 400 lines (configurable). |
| `file_size_signal_missing_reason` | warning | Ignore comment for `file_size_signal` is missing a reason. |
| `avoid_raw_string_in_widgets` | warning | Flags user-facing string literals in widget constructors (skips empty / punctuation-only). |
| `avoid_widget_returning_methods` | warning | Flags methods/functions that return `Widget` (extract a widget class instead). |
| `models_are_dtos` | warning | Flags `ChangeNotifier` / mutable fields under `lib/data/models/`. |

## Suppressing `file_size_signal`

This rule is a **signal, not a law**. Suppressions require a mandatory reason
after a comma (custom_lint's ignore parser splits on commas):

```dart
// ignore_for_file: file_size_signal, legacy chat screen pending split
```

A bare `// ignore_for_file: file_size_signal` (no reason) reports
`file_size_signal_missing_reason` instead.

## Configuration

Option keys must be siblings of the rule name (custom_lint's YAML shape):

```yaml
custom_lint:
  rules:
    - file_size_signal:
      max_lines: 400
    - avoid_raw_string_in_widgets:
      targets:
        AppButton: [label]
        TerminalAppBar: [title]
    - avoid_widget_returning_methods
    - models_are_dtos
```

## Running

```bash
# From the repo root (covers app, widgetbook, and the example fixtures)
make custom-lint

# Or directly
dart run custom_lint
```

## Testing

Fixtures live in `example/` and use `// expect_lint:` comments. A clean
`dart run custom_lint` exit from the example package means every rule fires
exactly where expected.
