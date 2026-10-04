import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/utils/datetime_extensions.dart';
import '../../../domain/providers/session_providers.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import '../../widgets/app_error_widget/app_error_widget.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';

class RecentSessionsWidget extends ConsumerWidget {
  const RecentSessionsWidget({
    super.key,
    required this.onViewAll,
    required this.onNewSession,
  });

  final VoidCallback onViewAll;
  final VoidCallback onNewSession;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final sessions = ref.watch(recentSessionsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(l10n.recentSessions, style: AppTypography.titleMedium),
        ),
        const SizedBox(height: AppSizing.gapSmall),
        Wrap(
          spacing: AppSizing.gapSmall,
          runSpacing: AppSizing.gapSmall,
          children: [
            AppButton(
              label: l10n.newSession,
              icon: Icons.add,
              variant: AppButtonVariant.secondary,
              onPressed: onNewSession,
            ),
            AppButton(
              label: l10n.viewAllSessions,
              variant: AppButtonVariant.ghost,
              onPressed: onViewAll,
            ),
          ],
        ),
        const SizedBox(height: AppSizing.gapMedium),
        sessions.when(
          data: (sessions) => sessions.isEmpty
              ? Text(l10n.noSessionsTitle)
              : Column(
                  children: [
                    for (final session in sessions)
                      ListTile(
                        key: ValueKey(session.id),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          session.title.trim().isEmpty
                              ? session.slug
                              : session.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          l10n.sessionUpdatedAgo(
                            DateTime.fromMillisecondsSinceEpoch(
                              session.time.updated,
                            ).timeAgo(),
                          ),
                        ),
                      ),
                  ],
                ),
          loading: () => Semantics(
            label: l10n.loadingSessions,
            child: const Center(child: LoadingIndicator()),
          ),
          error: (_, _) => AppErrorWidget(
            message: l10n.sessionsErrorTitle,
            onRetry: () => ref.invalidate(sessionsListProvider),
          ),
        ),
      ],
    );
  }
}
