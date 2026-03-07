import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

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
      home: const PlaceholderScreen(),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OpenCode Remote')),
      body: const Center(child: Text('OpenCode Remote App')),
    );
  }
}
