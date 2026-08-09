import 'package:flutter/material.dart';

import '../../../core/constants/app_sizing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../widgets/app_bar/terminal_app_bar.dart';
import '../../widgets/app_button/app_button.dart';
import '../../widgets/app_button/app_button_variant.dart';
import 'discovery_debug_screen.dart';
import 'manual_connect_widget.dart';

/// Connect screen: manual host/port form (+ mDNS debug entry until F1.3).
class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: TerminalAppBar(title: l10n.connectTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizing.gapLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
