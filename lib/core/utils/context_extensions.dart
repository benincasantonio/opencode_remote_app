import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  void showSnackBar(
    String message, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    try {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(content: Text(message), action: action, duration: duration),
      );
    } catch (_) {
      throw AssertionError(
        'showSnackBar must be called within a Scaffold context',
      );
    }
  }
}
