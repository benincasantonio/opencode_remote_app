import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../services/discovered_server.dart';

/// One discovered LAN server: tap to connect (or disabled while connecting).
class DiscoveredServerTile extends StatelessWidget {
  const DiscoveredServerTile({super.key, required this.server, this.onTap});

  final DiscoveredServer server;

  /// Connect callback; null while a connection attempt is in progress.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizing.gapSmall),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(server.name, style: AppTypography.titleMedium),
        subtitle: Text(
          '${server.host}:${server.port}',
          style: AppTypography.codeSmall,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: AppSizing.iconTiny,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
