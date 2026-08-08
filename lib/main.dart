import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/context_extensions.dart';
import 'l10n/app_localizations.dart';
import 'presentation/screens/connect/discovery_debug_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DiscoveryDebugScreen(),
    );
  }
}
