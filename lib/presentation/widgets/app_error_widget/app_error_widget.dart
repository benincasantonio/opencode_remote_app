import 'package:flutter/material.dart';
import 'app_error_compact_mode.dart';
import 'app_error_full_mode.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.compact = false,
  });

  final String message;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return AppErrorCompactMode(message: message, onRetry: onRetry);
    }
    return AppErrorFullMode(message: message, onRetry: onRetry);
  }
}
