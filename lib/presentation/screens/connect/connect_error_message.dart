import '../../../core/errors/app_exception.dart';
import '../../../l10n/app_localizations.dart';

/// Maps a connection [AppException] to a localized user-facing string.
String? connectErrorMessage(AppLocalizations l10n, AppException? error) {
  if (error == null) {
    return null;
  }

  return switch (error) {
    AuthException() => l10n.connectErrorAuth,
    NetworkException() => l10n.connectErrorNetwork,
    TimeoutException() => l10n.connectErrorTimeout,
    ServerException(:final message) => l10n.connectErrorServer(message),
    _ => l10n.connectErrorGeneric,
  };
}
