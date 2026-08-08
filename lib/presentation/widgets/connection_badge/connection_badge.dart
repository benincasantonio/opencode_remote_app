import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import 'connection_status.dart';

class ConnectionBadge extends StatefulWidget {
  const ConnectionBadge({super.key, required this.status, this.serverName});

  final ConnectionStatus status;
  final String? serverName;

  @override
  State<ConnectionBadge> createState() => _ConnectionBadgeState();
}

class _ConnectionBadgeState extends State<ConnectionBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _updateAnimation();
  }

  @override
  void didUpdateWidget(ConnectionBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.status == ConnectionStatus.connecting) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _dotColor() {
    return switch (widget.status) {
      ConnectionStatus.connected => AppColors.success,
      ConnectionStatus.connecting => AppColors.warning,
      ConnectionStatus.disconnected => AppColors.textMuted,
      ConnectionStatus.error => AppColors.error,
    };
  }

  String _label() {
    final l10n = context.l10n;
    return switch (widget.status) {
      ConnectionStatus.connected => l10n.statusConnected,
      ConnectionStatus.connecting => l10n.statusConnecting,
      ConnectionStatus.disconnected => l10n.statusDisconnected,
      ConnectionStatus.error => l10n.statusError,
    };
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = _dotColor();
    final label = _label();
    final showServerName = widget.serverName != null;

    final dot = Container(
      width: AppSizing.dotSize,
      height: AppSizing.dotSize,
      decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.status == ConnectionStatus.connecting
            ? FadeTransition(opacity: _pulseAnimation, child: dot)
            : dot,
        const SizedBox(width: AppSizing.gapSmall),
        Text(label, style: AppTypography.label.copyWith(color: dotColor)),
        if (showServerName) ...[
          const SizedBox(width: AppSizing.gapSmall),
          Text(
            '·',
            style: AppTypography.label.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(width: AppSizing.gapSmall),
          Text(
            widget.serverName!,
            style: AppTypography.label.copyWith(color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}
