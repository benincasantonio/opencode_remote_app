import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:opencode_remote_app/l10n/app_localizations.dart';

/// Pumps [home] inside a [MaterialApp] wired with the app's localization
/// delegates so that widgets using `context.l10n` resolve correctly.
Future<void> pumpWidgetWithL10n(
  WidgetTester tester,
  Widget home, {
  Locale? locale,
}) {
  return tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}
