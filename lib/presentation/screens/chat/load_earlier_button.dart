import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import '../../widgets/loading_indicator/loading_indicator_size.dart';

/// Asks for the previous page of a transcript.
class LoadEarlierButton extends StatelessWidget {
  const LoadEarlierButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizing.gapSmall),
      child: isLoading
          ? const Center(
              child: LoadingIndicator(size: LoadingIndicatorSize.small),
            )
          : Center(
              child: AppButton(
                label: context.l10n.loadEarlier,
                variant: AppButtonVariant.ghost,
                onPressed: onPressed,
              ),
            ),
    );
  }
}
