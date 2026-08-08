// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OpenCode Remote';

  @override
  String get retry => 'Retry';

  @override
  String get copyCode => 'Copy code';

  @override
  String get statusConnected => 'Connected';

  @override
  String get statusConnecting => 'Connecting…';

  @override
  String get statusDisconnected => 'Disconnected';

  @override
  String get statusError => 'Error';

  @override
  String get discoveryTitle => 'mDNS Discovery';

  @override
  String get start => 'Start';

  @override
  String get stop => 'Stop';

  @override
  String get discovering => 'DISCOVERING';

  @override
  String get idle => 'IDLE';

  @override
  String serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servers',
      one: '1 server',
    );
    return '$_temp0';
  }

  @override
  String get searchingForServers => 'Searching for servers…';

  @override
  String get noServersYet => 'No servers yet.\nTap Start to begin discovery.';
}
