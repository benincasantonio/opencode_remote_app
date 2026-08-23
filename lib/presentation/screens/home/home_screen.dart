import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/server_providers.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/connection_badge/connection_status.dart';
import 'server_status_widget.dart';

/// Home dashboard: live health status while connected.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final connection = ref.watch(connectionProvider);
    final healthPolling = ref.watch(healthPollingProvider);

    final health = healthPolling.value ?? connection.health;
    final ConnectionStatus status;
    if (healthPolling.hasError || health == null) {
      status = ConnectionStatus.error;
    } else if (!health.healthy) {
      status = ConnectionStatus.unhealthy;
    } else {
      status = ConnectionStatus.connected;
    }
    final healthUnavailable = healthPolling.hasError || health == null;
    final identity = connection.displayName ?? connection.baseUrl ?? '';

    return Scaffold(
      appBar: TerminalAppBar(title: l10n.homeTitle, connectionStatus: status),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: ServerStatusWidget(
          serverIdentity: identity,
          health: health,
          status: status,
          healthUnavailable: healthUnavailable,
          onDisconnect: () =>
              ref.read(connectionProvider.notifier).disconnect(),
        ),
      ),
    );
  }
}
