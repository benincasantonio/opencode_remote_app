import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/saved_server.dart';
import '../../../domain/providers/saved_server_providers.dart';
import '../../widgets/app_error_widget/app_error_widget.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import '../../widgets/loading_indicator/loading_indicator_size.dart';
import '_saved_server_tile.dart';

/// Section listing previously connected servers for quick reconnect.
class SavedServersList extends ConsumerStatefulWidget {
  const SavedServersList({super.key});

  @override
  ConsumerState<SavedServersList> createState() => _SavedServersListState();
}

class _SavedServersListState extends ConsumerState<SavedServersList> {
  /// Servers removed via swipe that are still being deleted asynchronously.
  /// Keeps the dismissed [Dismissible] out of the tree on the same frame.
  final Set<String> _dismissedIds = {};

  Future<void> _delete(SavedServer server) async {
    setState(() => _dismissedIds.add(server.id));
    await ref.read(savedServersProvider.notifier).delete(server.id);
    if (!mounted) {
      return;
    }
    context.showSnackBar(context.l10n.serverDeleted);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final savedServers = ref.watch(savedServersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.savedServersTitle, style: AppTypography.label),
        const SizedBox(height: AppSizing.gapMedium),
        savedServers.when(
          loading: () => const Center(
            child: LoadingIndicator(size: LoadingIndicatorSize.small),
          ),
          error: (error, stackTrace) => AppErrorWidget(
            message: l10n.savedServersError,
            onRetry: () => ref.invalidate(savedServersProvider),
            compact: true,
          ),
          data: (servers) {
            final visible = [
              for (final server in servers)
                if (!_dismissedIds.contains(server.id)) server,
            ];
            if (visible.isEmpty) {
              return Text(l10n.noSavedServers, style: AppTypography.bodyMedium);
            }
            return Column(
              children: [
                for (final server in visible)
                  SavedServerTile(
                    server: server,
                    onDelete: () => _delete(server),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
