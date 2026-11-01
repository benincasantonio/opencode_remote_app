import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/part.dart';
import '../../widgets/markdown_renderer/markdown_renderer.dart';

/// Renders one message part. Step markers are omitted.
class PartRenderer extends StatelessWidget {
  const PartRenderer({super.key, required this.part});

  final MessagePart part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return switch (part) {
      TextPart(:final text) => Padding(
        padding: const EdgeInsets.only(top: AppSizing.gapSmall),
        child: MarkdownRenderer(data: text),
      ),
      ReasoningPart(:final text) when text.trim().isEmpty =>
        const SizedBox.shrink(),
      ReasoningPart(:final text) => Padding(
        padding: const EdgeInsets.only(top: AppSizing.gapSmall),
        child: Text(
          text,
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
        ),
      ),
      ToolPart(:final tool, :final state) => Padding(
        padding: const EdgeInsets.only(top: AppSizing.gapSmall),
        child: Text(
          l10n.toolPartLine(tool, switch (state) {
            ToolStatePending() => l10n.toolStatusPending,
            ToolStateRunning() => l10n.toolStatusRunning,
            ToolStateCompleted() => l10n.toolStatusCompleted,
            ToolStateError() => l10n.toolStatusError,
          }),
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
        ),
      ),
      StepStartPart() || StepFinishPart() => const SizedBox.shrink(),
      OtherPart(:final type) => Padding(
        padding: const EdgeInsets.only(top: AppSizing.gapSmall),
        child: Text(
          type,
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
        ),
      ),
    };
  }
}
