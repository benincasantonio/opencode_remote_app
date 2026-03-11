import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'loading_indicator_size.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.size = LoadingIndicatorSize.large,
    this.message,
  });

  final LoadingIndicatorSize size;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final isSmall = size == LoadingIndicatorSize.small;
    final spinnerSize = isSmall ? 20.0 : 40.0;
    final strokeWidth = isSmall ? 2.0 : 4.0;

    final spinner = SizedBox(
      width: spinnerSize,
      height: spinnerSize,
      child: CircularProgressIndicator(
        color: AppColors.primaryGreen,
        strokeWidth: strokeWidth,
      ),
    );

    if (isSmall || message == null) {
      return spinner;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        spinner,
        const SizedBox(height: 16.0),
        Text(
          message!,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
