import 'package:flutter/material.dart';
import 'package:opencode_remote_app/core/theme/app_colors.dart';
import 'package:opencode_remote_app/core/theme/app_typography.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_badge.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';

/// A terminal-styled app bar that wraps Flutter's [AppBar] with a subtle
/// bottom border and optional [ConnectionBadge].
///
/// Implements [PreferredSizeWidget] so it can be used directly in
/// [Scaffold.appBar].
class TerminalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TerminalAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showConnectionBadge = true,
    this.connectionStatus = ConnectionStatus.disconnected,
    this.serverName,
  });

  /// The title displayed in the center of the app bar.
  final String title;

  /// Optional action widgets rendered on the trailing side.
  final List<Widget>? actions;

  /// Optional leading widget. When `null`, the default back button is shown
  /// if the navigator can pop.
  final Widget? leading;

  /// Whether to display the [ConnectionBadge] in the actions area.
  final bool showConnectionBadge;

  /// The current connection status forwarded to [ConnectionBadge].
  /// Only used when [showConnectionBadge] is `true`.
  final ConnectionStatus connectionStatus;

  /// Optional server name forwarded to [ConnectionBadge].
  final String? serverName;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      leading: leading,
      centerTitle: true,
      elevation: 0,
      title: Text(title, style: AppTypography.headlineMedium),
      shape: const Border(
        bottom: BorderSide(color: AppColors.border, width: 1),
      ),
      actions: [
        if (showConnectionBadge)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ConnectionBadge(
              status: connectionStatus,
              serverName: serverName,
            ),
          ),
        ...?actions,
      ],
    );
  }
}
