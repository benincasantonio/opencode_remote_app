import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/session.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/server_providers.dart';
import '../../router/app_router.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/connection_badge/connection_status.dart';
import '../sessions/new_session_dialog.dart';
import 'recent_sessions_widget.dart';
import 'server_status_widget.dart';

/// Home dashboard: live server health and the five most recent sessions.
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
      appBar: TerminalAppBar(
        title: l10n.homeTitle,
        connectionStatus: status,
        actions: [
          IconButton(
            icon: const Icon(Icons.forum_outlined),
            tooltip: l10n.sessionsTitle,
            onPressed: () => context.push(sessionsPath),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: Column(
          children: [
            ServerStatusWidget(
              serverIdentity: identity,
              health: health,
              status: status,
              healthUnavailable: healthUnavailable,
              onDisconnect: () =>
                  ref.read(connectionProvider.notifier).disconnect(),
            ),
            const SizedBox(height: AppSizing.gapLarge),
            RecentSessionsWidget(
              onViewAll: () => context.push(sessionsPath),
              onNewSession: () => showDialog<Session>(
                context: context,
                barrierDismissible: false,
                builder: (context) => const NewSessionDialog(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
