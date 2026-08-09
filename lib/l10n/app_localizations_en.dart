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

  @override
  String get connectTitle => 'Connect';

  @override
  String get openDiscoveryDebug => 'Open mDNS Discovery';

  @override
  String get hostLabel => 'Host';

  @override
  String get portLabel => 'Port';

  @override
  String get usernameLabel => 'Username (optional)';

  @override
  String get passwordLabel => 'Password (optional)';

  @override
  String get connectButton => 'Connect';

  @override
  String get hostRequired => 'Enter a host';

  @override
  String get portRequired => 'Enter a port';

  @override
  String get portInvalid => 'Enter a valid port (1–65535)';

  @override
  String get connectErrorAuth =>
      'Authentication failed. Check username and password.';

  @override
  String get connectErrorNetwork =>
      'Could not reach the server. Check host and port.';

  @override
  String get connectErrorTimeout => 'Connection timed out. Try again.';

  @override
  String connectErrorServer(String message) {
    return 'Server error: $message';
  }

  @override
  String get connectErrorGeneric => 'Something went wrong. Try again.';

  @override
  String get homeTitle => 'Home';

  @override
  String get connectedServerLabel => 'Connected server';

  @override
  String get serverHealthLabel => 'Health';

  @override
  String get serverHealthy => 'Healthy';

  @override
  String get serverUnhealthy => 'Unhealthy';

  @override
  String serverVersion(String version) {
    return 'Version $version';
  }

  @override
  String get serverHealthUnavailable => 'Health information unavailable';
}
