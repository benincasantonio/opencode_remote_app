import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'OpenCode Remote'**
  String get appTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @copyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copyCode;

  /// No description provided for @statusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get statusConnected;

  /// No description provided for @statusConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get statusConnecting;

  /// No description provided for @statusDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get statusDisconnected;

  /// No description provided for @statusError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get statusError;

  /// No description provided for @discoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'mDNS Discovery'**
  String get discoveryTitle;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @discovering.
  ///
  /// In en, this message translates to:
  /// **'DISCOVERING'**
  String get discovering;

  /// No description provided for @idle.
  ///
  /// In en, this message translates to:
  /// **'IDLE'**
  String get idle;

  /// No description provided for @serverCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 server} other{{count} servers}}'**
  String serverCount(int count);

  /// No description provided for @searchingForServers.
  ///
  /// In en, this message translates to:
  /// **'Searching for servers…'**
  String get searchingForServers;

  /// No description provided for @noServersYet.
  ///
  /// In en, this message translates to:
  /// **'No servers yet.\nTap Start to begin discovery.'**
  String get noServersYet;

  /// No description provided for @connectTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectTitle;

  /// No description provided for @openDiscoveryDebug.
  ///
  /// In en, this message translates to:
  /// **'Open mDNS Discovery'**
  String get openDiscoveryDebug;

  /// No description provided for @hostLabel.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get hostLabel;

  /// No description provided for @portLabel.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get portLabel;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username (optional)'**
  String get usernameLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password (optional)'**
  String get passwordLabel;

  /// No description provided for @connectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectButton;

  /// No description provided for @hostRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a host'**
  String get hostRequired;

  /// No description provided for @portRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a port'**
  String get portRequired;

  /// No description provided for @portInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid port (1–65535)'**
  String get portInvalid;

  /// No description provided for @connectErrorAuth.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Check username and password.'**
  String get connectErrorAuth;

  /// No description provided for @connectErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check host and port.'**
  String get connectErrorNetwork;

  /// No description provided for @connectErrorTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Try again.'**
  String get connectErrorTimeout;

  /// No description provided for @connectErrorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error: {message}'**
  String connectErrorServer(String message);

  /// No description provided for @connectErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get connectErrorGeneric;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @connectedServerLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected server'**
  String get connectedServerLabel;

  /// No description provided for @serverHealthLabel.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get serverHealthLabel;

  /// No description provided for @serverHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get serverHealthy;

  /// No description provided for @serverUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Unhealthy'**
  String get serverUnhealthy;

  /// No description provided for @serverVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String serverVersion(String version);

  /// No description provided for @serverHealthUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Health information unavailable'**
  String get serverHealthUnavailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
