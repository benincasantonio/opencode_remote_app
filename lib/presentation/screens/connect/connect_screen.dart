import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/app_error_widget/app_error_widget.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import 'connect_error_message.dart';
import 'discovered_servers_list.dart';
import 'manual_connect_widget.dart';
import 'saved_servers_list.dart';

/// Connect screen: shared error + saved-server quick reconnect + LAN
/// discovery + manual host/port form.
class ConnectScreen extends ConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final connection = ref.watch(connectionProvider);

    if (connection.bootInProgress) {
      return Scaffold(
        appBar: TerminalAppBar(title: l10n.connectTitle),
        body: Center(child: LoadingIndicator(message: l10n.reconnecting)),
      );
    }

    final errorText = connectErrorMessage(l10n, connection.error);

    return Scaffold(
      appBar: TerminalAppBar(title: l10n.connectTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (errorText != null) ...[
              AppErrorWidget(message: errorText, compact: true),
              const SizedBox(height: AppSizing.gapXLarge),
            ],
            const SavedServersList(),
            const SizedBox(height: AppSizing.gapXLarge),
            const DiscoveredServersList(),
            const SizedBox(height: AppSizing.gapXLarge),
            const ManualConnectWidget(),
          ],
        ),
      ),
    );
  }
}
