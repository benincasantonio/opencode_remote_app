import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/utils/datetime_extensions.dart';
import '../../../data/models/session.dart';
import 'session_status_badge.dart';

/// Renders a single session row with title, slug, directory, relative updated
/// time, and status badge.
class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.session,
    this.status = const SessionStatus.idle(),
    this.onTap,
    this.trailing,
  });

  final Session session;
  final SessionStatus status;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final displayTitle = session.title.trim().isNotEmpty
        ? session.title
        : session.slug;
    final updatedDate = DateTime.fromMillisecondsSinceEpoch(
      session.time.updated,
    );
    final relativeTime = updatedDate.timeAgo();
    final updatedText = l10n.sessionUpdatedAgo(relativeTime);

    final String secondaryText;
    if (session.title.trim().isNotEmpty && session.slug.isNotEmpty) {
      secondaryText = '${session.slug} · ${session.directory}';
    } else {
      secondaryText = session.directory;
    }

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizing.gapLarge,
        vertical: AppSizing.gapSmall,
      ),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizing.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppSizing.gapLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      displayTitle,
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSizing.gapMedium),
                  SessionStatusBadge(status: status),
                ],
              ),
              const SizedBox(height: AppSizing.gapSmall),
              Text(
                secondaryText,
                style: AppTypography.codeSmall.copyWith(
                  color: AppColors.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: AppSizing.gapSmall),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      updatedText,
                      style: AppTypography.label.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  ?trailing,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
