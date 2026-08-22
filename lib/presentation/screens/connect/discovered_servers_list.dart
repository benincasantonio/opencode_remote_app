import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/discovery_providers.dart';
import '../../../services/discovered_server.dart';
import '../../widgets/app_error_widget/app_error_widget.dart';
import '../../widgets/connection_badge/connection_status.dart';
import '_discovered_server_tile.dart';

/// Section listing OpenCode servers advertised on the local network via mDNS.
class DiscoveredServersList extends ConsumerWidget {
  const DiscoveredServersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isConnecting =
        ref.watch(connectionProvider).status == ConnectionStatus.connecting;
    final discovery = ref.watch(discoveredServersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.lanServersTitle, style: AppTypography.label),
        const SizedBox(height: AppSizing.gapMedium),
        discovery.when(
          loading: () => _SearchingMessage(),
          error: (error, stackTrace) => AppErrorWidget(
            message: l10n.discoveryUnavailable,
            onRetry: () => ref.invalidate(discoveredServersProvider),
            compact: true,
          ),
          data: (servers) {
            final sorted = _sortedCopy(servers);
            if (sorted.isEmpty) {
              return const _SearchingMessage();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final server in sorted)
                  DiscoveredServerTile(
                    server: server,
                    onTap: isConnecting
                        ? null
                        : () {
                            ref
                                .read(connectionProvider.notifier)
                                .connect(host: server.host, port: server.port);
                          },
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  List<DiscoveredServer> _sortedCopy(List<DiscoveredServer> servers) {
    final copy = List<DiscoveredServer>.of(servers);
    copy.sort((a, b) {
      final byName = a.name.toLowerCase().compareTo(b.name.toLowerCase());
      if (byName != 0) {
        return byName;
      }
      final byHost = a.host.compareTo(b.host);
      if (byHost != 0) {
        return byHost;
      }
      return a.port.compareTo(b.port);
    });
    return copy;
  }
}

class _SearchingMessage extends StatelessWidget {
  const _SearchingMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.searchingForServers,
      style: AppTypography.bodyMedium,
    );
  }
}
