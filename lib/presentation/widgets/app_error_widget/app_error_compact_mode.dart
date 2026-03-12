import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';

class AppErrorCompactMode extends StatelessWidget {
  const AppErrorCompactMode({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizing.gapLarge,
        vertical: AppSizing.gapMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 20, color: AppColors.error),
          const SizedBox(width: AppSizing.gapSmall),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: AppSizing.gapSmall),
            IconButton(
              icon: const Icon(Icons.refresh),
              iconSize: AppSizing.iconSmall,
              color: AppColors.textSecondary,
              onPressed: onRetry,
              tooltip: 'Retry',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ],
      ),
    );
  }
}
