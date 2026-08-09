import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/connection_badge/connection_status.dart';
import '../../widgets/terminal_text/terminal_text.dart';

/// Stub Home screen showing the connected server and one-shot health result.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final connection = ref.watch(connectionProvider);
    final theme = Theme.of(context);
    final health = connection.health;

    return Scaffold(
      appBar: TerminalAppBar(
        title: l10n.homeTitle,
        connectionStatus: ConnectionStatus.connected,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.connectedServerLabel,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSizing.gapSmall),
            TerminalText(
              text: connection.displayName ?? connection.baseUrl ?? '',
            ),
            const SizedBox(height: AppSizing.gapXLarge),
            Text(
              l10n.serverHealthLabel,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSizing.gapSmall),
            if (health != null) ...[
              Text(
                health.healthy
                    ? l10n.serverHealthy
                    : l10n.serverUnhealthy,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizing.gapSmall),
              Text(
                l10n.serverVersion(health.version),
                style: theme.textTheme.bodyLarge,
              ),
            ] else
              Text(
                l10n.serverHealthUnavailable,
                style: theme.textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}
