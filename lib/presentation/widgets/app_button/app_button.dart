import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/core/constants/app_sizing.dart';
import 'app_button_variant.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || onPressed == null;
    final effectiveOnPressed = isDisabled ? null : onPressed;

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _getForegroundColor(),
            ),
          ),
          const SizedBox(width: AppSizing.gapSmall),
        ] else if (icon != null) ...[
          Icon(icon, size: AppSizing.iconSmall, color: _getForegroundColor()),
          const SizedBox(width: AppSizing.gapSmall),
        ],
        Text(
          label,
          style: AppTypography.label.copyWith(color: _getForegroundColor()),
        ),
      ],
    );

    switch (variant) {
      case AppButtonVariant.primary:
        return FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.primaryGreen.withValues(alpha: 0.5),
            disabledForegroundColor: Colors.white.withValues(alpha: .7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.secondary:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            disabledForegroundColor: AppColors.textMuted,
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.destructive:
        return FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.error.withValues(alpha: 0.5),
            disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
            ),
          ),
          child: child,
        );
      case AppButtonVariant.ghost:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accentCyan,
            disabledForegroundColor: AppColors.textMuted,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
            ),
          ),
          child: child,
        );
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.destructive:
        return Colors.white;
      case AppButtonVariant.secondary:
        return AppColors.textPrimary;
      case AppButtonVariant.ghost:
        return AppColors.accentCyan;
    }
  }
}
