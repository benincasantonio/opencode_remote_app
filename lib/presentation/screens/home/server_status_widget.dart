import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/server_health.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import '../../widgets/connection_badge/connection_badge.dart';
import '../../widgets/connection_badge/connection_status.dart';
import '../../widgets/terminal_text/terminal_text.dart';

/// Home dashboard card with server identity, live health status, version,
/// and a confirmed Disconnect action.
class ServerStatusWidget extends StatelessWidget {
  const ServerStatusWidget({
    super.key,
    required this.serverIdentity,
    required this.health,
    required this.status,
    required this.healthUnavailable,
    required this.onDisconnect,
  });

  final String serverIdentity;
  final ServerHealth? health;
  final ConnectionStatus status;

  /// True when live health cannot be resolved (poll error or missing data).
  final bool healthUnavailable;

  final Future<void> Function() onDisconnect;

  Future<void> _confirmDisconnect(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final dialogL10n = dialogContext.l10n;
        return AlertDialog(
          title: Text(dialogL10n.disconnectDialogTitle),
          content: Text(dialogL10n.disconnectDialogMessage(serverIdentity)),
          actions: [
            AppButton(
              label: dialogL10n.cancel,
              variant: AppButtonVariant.ghost,
              onPressed: () => Navigator.pop(dialogContext, false),
            ),
            AppButton(
              label: dialogL10n.disconnect,
              variant: AppButtonVariant.destructive,
              icon: Icons.logout,
              onPressed: () => Navigator.pop(dialogContext, true),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await onDisconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final healthValue = health;

    final String healthDetail;
    if (healthValue == null || healthUnavailable) {
      healthDetail = l10n.serverHealthUnavailable;
    } else if (healthValue.healthy) {
      healthDetail = l10n.serverHealthy;
    } else {
      healthDetail = l10n.serverUnhealthy;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.connectedServerLabel, style: textTheme.titleMedium),
            const SizedBox(height: AppSizing.gapSmall),
            TerminalText(text: serverIdentity),
            const SizedBox(height: AppSizing.gapXLarge),
            Text(l10n.serverHealthLabel, style: textTheme.titleMedium),
            const SizedBox(height: AppSizing.gapSmall),
            Align(
              alignment: Alignment.centerLeft,
              child: ConnectionBadge(status: status),
            ),
            const SizedBox(height: AppSizing.gapSmall),
            Text(healthDetail, style: textTheme.bodyLarge),
            if (healthValue != null) ...[
              const SizedBox(height: AppSizing.gapSmall),
              Text(
                l10n.serverVersion(healthValue.version),
                style: textTheme.bodyLarge,
              ),
            ],
            const SizedBox(height: AppSizing.gapXLarge),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: AppSizing.gapXLarge),
            AppButton(
              label: l10n.disconnect,
              variant: AppButtonVariant.destructive,
              icon: Icons.logout,
              onPressed: () => _confirmDisconnect(context),
            ),
          ],
        ),
      ),
    );
  }
}
