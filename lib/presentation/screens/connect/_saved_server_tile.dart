import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/utils/datetime_extensions.dart';
import '../../../data/models/saved_server.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../../domain/providers/saved_server_providers.dart';

enum _SavedServerAction { setDefault, delete }

/// One saved server: tap to reconnect, swipe to delete, overflow menu for
/// "set as default" / delete.
class SavedServerTile extends ConsumerWidget {
  const SavedServerTile({
    super.key,
    required this.server,
    required this.onDelete,
  });

  final SavedServer server;

  /// Invoked when the user deletes the server (swipe or menu).
  /// The parent removes the tile from the tree synchronously.
  final VoidCallback onDelete;

  Future<void> _connect(WidgetRef ref) async {
    final credentials = await ref
        .read(savedServerRepositoryProvider)
        .getCredentials(server.id);
    await ref.read(connectionProvider.notifier).connect(
      host: server.host,
      port: server.port,
      username: credentials?.username,
      password: credentials?.password,
    );
  }

  Future<void> _onSetDefault(BuildContext context, WidgetRef ref) async {
    await ref.read(savedServersProvider.notifier).setDefault(server.id);
    if (!context.mounted) {
      return;
    }
    context.showSnackBar(context.l10n.defaultServerSet);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final lastConnected = server.lastConnectedAt;

    return Dismissible(
      key: ValueKey(server.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSizing.gapLarge),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.textPrimary),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSizing.gapSmall),
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
          side: const BorderSide(color: AppColors.border),
        ),
        child: ListTile(
          onTap: () => _connect(ref),
          leading: server.isDefault
              ? Icon(
                  Icons.star,
                  color: AppColors.warning,
                  size: AppSizing.iconSmall,
                )
              : null,
          title: Text(
            server.displayName,
            style: AppTypography.titleMedium,
          ),
          subtitle: lastConnected == null
              ? null
              : Text(
                  '${l10n.lastConnected} ${lastConnected.timeAgo()}',
                  style: AppTypography.bodySmall,
                ),
          trailing: PopupMenuButton<_SavedServerAction>(
            icon: const Icon(Icons.more_vert, color: AppColors.textMuted),
            onSelected: (action) {
              switch (action) {
                case _SavedServerAction.setDefault:
                  _onSetDefault(context, ref);
                case _SavedServerAction.delete:
                  onDelete();
              }
            },
            itemBuilder: (context) => [
              if (!server.isDefault)
                PopupMenuItem(
                  value: _SavedServerAction.setDefault,
                  child: Text(l10n.setAsDefault),
                ),
              PopupMenuItem(
                value: _SavedServerAction.delete,
                child: Text(
                  l10n.deleteServer,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
