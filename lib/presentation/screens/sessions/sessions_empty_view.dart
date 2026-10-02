import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';

/// Centered terminal-styled empty state for the sessions screen.
class SessionsEmptyView extends StatelessWidget {
  const SessionsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizing.gapXXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.terminal_outlined,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSizing.gapLarge),
            Text(
              l10n.noSessionsTitle,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizing.gapSmall),
            Text(
              l10n.noSessionsSubtitle,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
