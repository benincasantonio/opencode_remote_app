import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Text(label);
}

class TerminalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TerminalAppBar({super.key, required this.title});
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) => AppBar(title: Text(title));
}

class FakeL10n {
  String get retry => 'Retry';
}

extension FakeL10nX on BuildContext {
  FakeL10n get l10n => FakeL10n();
}
