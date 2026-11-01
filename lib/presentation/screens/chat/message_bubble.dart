import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/message.dart';
import 'part_renderer.dart';

/// Role label plus the parts of one transcript message.
class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageWithParts message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final info = message.info;
    final isUser = info is UserMessage;
    final error = switch (info) {
      AssistantMessage(:final error) => error,
      UserMessage() => null,
    };
    final errorLabel = error == null
        ? null
        : (error.message.isNotEmpty ? error.message : error.name);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizing.gapLarge,
        vertical: AppSizing.gapSmall,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizing.gapLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isUser ? l10n.messageRoleUser : l10n.messageRoleAssistant,
                style: AppTypography.label.copyWith(
                  color: isUser ? AppColors.accentCyan : AppColors.primaryGreen,
                ),
              ),
              if (message.parts.isEmpty && errorLabel == null)
                const SizedBox(height: AppSizing.gapSmall),
              for (final part in message.parts) PartRenderer(part: part),
              if (errorLabel != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSizing.gapSmall),
                  child: Text(
                    errorLabel,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
