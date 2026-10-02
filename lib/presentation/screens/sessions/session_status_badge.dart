import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../data/models/session.dart';

/// A compact terminal-styled chip indicating the live [SessionStatus].
class SessionStatusBadge extends StatefulWidget {
  const SessionStatusBadge({super.key, required this.status});

  final SessionStatus status;

  @override
  State<SessionStatusBadge> createState() => _SessionStatusBadgeState();
}

class _SessionStatusBadgeState extends State<SessionStatusBadge>
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
  void didUpdateWidget(SessionStatusBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status.runtimeType != widget.status.runtimeType) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.status is SessionStatusBusy) {
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
      SessionStatusIdle() => AppColors.textMuted,
      SessionStatusBusy() => AppColors.primaryGreen,
      SessionStatusRetry() => AppColors.warning,
    };
  }

  String _label() {
    final l10n = context.l10n;
    return switch (widget.status) {
      SessionStatusIdle() => l10n.sessionStatusIdle,
      SessionStatusBusy() => l10n.sessionStatusBusy,
      SessionStatusRetry() => l10n.sessionStatusRetry,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _dotColor();
    final label = _label();
    final isBusy = widget.status is SessionStatusBusy;

    final dot = Container(
      width: AppSizing.dotSize,
      height: AppSizing.dotSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizing.gapSmall,
        vertical: AppSizing.gapTiny,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizing.radiusSmall),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isBusy)
            FadeTransition(opacity: _pulseAnimation, child: dot)
          else
            dot,
          const SizedBox(width: AppSizing.gapSmall),
          Text(label, style: AppTypography.label.copyWith(color: color)),
        ],
      ),
    );
  }
}
