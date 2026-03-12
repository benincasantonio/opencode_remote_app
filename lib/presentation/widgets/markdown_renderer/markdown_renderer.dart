import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/presentation/widgets/markdown_renderer/markdown_code_builder.dart';

class MarkdownRenderer extends StatelessWidget {
  const MarkdownRenderer({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        a: AppTypography.bodyMedium.copyWith(
          color: AppColors.accentCyan,
          decoration: TextDecoration.underline,
        ),
        p: AppTypography.bodyMedium,
        h1: AppTypography.headlineLarge,
        h1Padding: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        h2: AppTypography.headlineMedium,
        h2Padding: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        h3: AppTypography.titleLarge,
        h3Padding: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        h4: AppTypography.titleMedium,
        h4Padding: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        h5: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        h5Padding: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        h6: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        h6Padding: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        code: AppTypography.codeSmall.copyWith(
          backgroundColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
          color: AppColors.textPrimary,
        ),
        blockquote: AppTypography.bodyMedium.copyWith(
          color: AppColors.textMuted,
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(left: BorderSide(color: AppColors.border, width: 2.0)),
        ),
        blockquotePadding: const EdgeInsets.only(left: AppSizing.gapSmall),
        listBullet: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      builders: {'code': MarkdownCodeBuilder()},
    );
  }
}
