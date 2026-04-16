import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'presentation/screens/connect/discovery_debug_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenCode Remote',
      theme: AppTheme.dark(),
      home: const DiscoveryDebugScreen(),
    );
  }
}
