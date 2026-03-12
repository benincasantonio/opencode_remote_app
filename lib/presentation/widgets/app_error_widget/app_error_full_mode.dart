import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button.dart';
import 'package:opencode_remote_app/presentation/widgets/app_button/app_button_variant.dart';

class AppErrorFullMode extends StatelessWidget {
  const AppErrorFullMode({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizing.gapXXLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: AppSizing.gapLarge),
          Text(
            message,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSizing.gapLarge),
            AppButton(
              label: 'Retry',
              onPressed: onRetry,
              variant: AppButtonVariant.secondary,
              icon: Icons.refresh,
            ),
          ],
        ],
      ),
    );
  }
}
