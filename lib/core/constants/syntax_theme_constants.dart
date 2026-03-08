import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';

class SyntaxThemeConstants {
  SyntaxThemeConstants._();

  static SyntaxTheme terminalSyntaxTheme() {
    return SyntaxTheme.vscodeDark().copyWith(
      backgroundColor: AppColors.surfaceVariant,
      linesCountColor: AppColors.textMuted,
      baseStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontFamily: 'JetBrains Mono',
        fontSize: 13,
      ),
      commentStyle: TextStyle(
        color: AppColors.textMuted,
        fontStyle: FontStyle.italic,
      ),
      keywordStyle: const TextStyle(color: AppColors.accentCyan),
      stringStyle: const TextStyle(color: AppColors.success),
      classStyle: const TextStyle(color: AppColors.warning),
      punctuationStyle: const TextStyle(color: AppColors.textSecondary),
      zoomIconColor: AppColors.primaryGreen,
    );
  }
}
