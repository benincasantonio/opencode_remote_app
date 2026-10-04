import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/session.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/server_providers.dart';
import '../../../domain/providers/session_providers.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/app_error_widget/app_error_widget.dart';
import '../../widgets/connection_badge/connection_status.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import 'new_session_dialog.dart';
import 'session_tile.dart';
import 'session_delete_button.dart';
import 'sessions_empty_view.dart';

/// Screen displaying the list of OpenCode sessions from the connected server.
class SessionsListScreen extends ConsumerWidget {
  const SessionsListScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    await Future.wait([
      ref.refresh(sessionsListProvider.future),
      ref.refresh(sessionStatusesProvider.future),
    ]);
  }

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

    final sessionsListAsync = ref.watch(sessionsListProvider);
    final statusesAsync = ref.watch(sessionStatusesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.newSession,
        onPressed: () => showDialog<Session>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const NewSessionDialog(),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: TerminalAppBar(
        title: l10n.sessionsTitle,
        connectionStatus: status,
      ),
      body: sessionsListAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => _refresh(ref),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height * 0.7,
                    ),
                    child: const SessionsEmptyView(),
                  ),
                ],
              ),
            );
          }

          final statuses =
              statusesAsync.value ?? const <String, SessionStatus>{};

          return RefreshIndicator(
            onRefresh: () => _refresh(ref),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: AppSizing.gapSmall),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                final sessionStatus =
                    statuses[session.id] ?? const SessionStatus.idle();
                return SessionTile(
                  key: ValueKey(session.id),
                  session: session,
                  status: sessionStatus,
                  trailing: SessionDeleteButton(session: session),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: LoadingIndicator()),
        error: (error, _) => RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).height * 0.7,
                ),
                child: Center(
                  child: AppErrorWidget(
                    message: l10n.sessionsErrorTitle,
                    onRetry: () => _refresh(ref),
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
