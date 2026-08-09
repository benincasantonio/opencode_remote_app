// ignore_for_file: file_size_signal, fixture exercises other rules
import 'package:flutter/material.dart';

/// Minimal stand-in for the app's AppButton, used to exercise configured
/// extra targets of avoid_raw_string_in_widgets.
class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Text(label);
}

/// Minimal stand-in for TerminalAppBar.
class TerminalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TerminalAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(title: Text(title));
}

/// Fake l10n so the "good" path compiles without generated localizations.
class FakeL10n {
  String get retry => 'Retry';
}

extension on BuildContext {
  FakeL10n get l10n => FakeL10n();
}

class RawStringFixtures extends StatelessWidget {
  const RawStringFixtures({super.key});

  @override
  Widget build(BuildContext context) {
    final host = 'localhost';
    final port = 8080;

    return Column(
      children: [
        // expect_lint: avoid_raw_string_in_widgets
        const Text('Hello'),
        // expect_lint: avoid_raw_string_in_widgets
        const AppButton(label: 'Save'),
        // expect_lint: avoid_raw_string_in_widgets
        const TerminalAppBar(title: 'OpenCode'),
        // expect_lint: avoid_raw_string_in_widgets
        const Tooltip(message: 'More info', child: Icon(Icons.info)),

        // Allowed: interpolated (data, not copy).
        Text('$host:$port'),
        // Allowed: empty string.
        const Text(''),
        // Allowed: decorative punctuation (no letters).
        const Text('·'),
        // Allowed: l10n lookup.
        Text(context.l10n.retry),
        // Allowed: raw string outside a targeted widget constructor.
        Builder(
          builder: (context) {
            const unused = 'not in a widget ctor';
            return Text(unused);
          },
        ),
      ],
    );
  }
}
