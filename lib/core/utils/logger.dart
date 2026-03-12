import 'dart:developer';
import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static const _levelDebug = 500;
  static const _levelInfo = 800;
  static const _levelWarning = 900;
  static const _levelError = 1000;

  static void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    _log(_levelDebug, 'DEBUG', message, error, stackTrace, context);
  }

  static void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    _log(_levelInfo, 'INFO', message, error, stackTrace, context);
  }

  static void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    _log(_levelWarning, 'WARNING', message, error, stackTrace, context);
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  }) {
    _log(_levelError, 'ERROR', message, error, stackTrace, context);
  }

  static void _log(
    int level,
    String levelTag,
    String message,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  ) {
    if (kReleaseMode) {
      return;
    }

    final timestampIso = DateTime.now().toIso8601String();
    final timestampShort = DateTime.now().toIso8601String().substring(11, 19);

    final logMessage = _buildMessage(message, context, timestampIso, levelTag);

    if (kDebugMode) {
      _printToConsole(
        timestampShort,
        levelTag,
        message,
        error,
        stackTrace,
        context,
      );
    }

    log(logMessage, level: level, error: error, stackTrace: stackTrace);
  }

  static String _buildMessage(
    String message,
    Map<String, Object?>? context,
    String timestamp,
    String levelTag,
  ) {
    if (context == null || context.isEmpty) {
      return '[$timestamp] [$levelTag] $message';
    }

    final contextStr = context.entries
        .map((e) => '${e.key}=${e.value}')
        .join(', ');
    return '[$timestamp] [$levelTag] $message | Context: {$contextStr}';
  }

  static void _printToConsole(
    String timestampShort,
    String levelTag,
    String message,
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? context,
  ) {
    final prefix = '[$timestampShort] [$levelTag]';

    debugPrint('$prefix $message');

    if (context != null && context.isNotEmpty) {
      debugPrint('$prefix Context: $context');
    }

    if (error != null) {
      debugPrint('$prefix Error: $error');
    }

    if (stackTrace != null) {
      debugPrint('$prefix StackTrace:');
      debugPrint('$stackTrace');
    }
  }
}
