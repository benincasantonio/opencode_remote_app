import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../domain/providers/connection_providers.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import '../../widgets/loading_indicator/loading_indicator.dart';
import 'discovery_debug_screen.dart';
import 'manual_connect_widget.dart';
import 'saved_servers_list.dart';

/// Connect screen: saved-server quick reconnect + manual host/port form
/// (+ mDNS debug entry until F1.3).
class ConnectScreen extends ConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final bootInProgress = ref.watch(connectionProvider).bootInProgress;

    if (bootInProgress) {
      return Scaffold(
        appBar: TerminalAppBar(title: l10n.connectTitle),
        body: Center(
          child: LoadingIndicator(message: l10n.reconnecting),
        ),
      );
    }

    return Scaffold(
      appBar: TerminalAppBar(title: l10n.connectTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SavedServersList(),
            const SizedBox(height: AppSizing.gapXLarge),
            const ManualConnectWidget(),
            const SizedBox(height: AppSizing.gapXLarge),
            AppButton(
              label: l10n.openDiscoveryDebug,
              variant: AppButtonVariant.secondary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const DiscoveryDebugScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
