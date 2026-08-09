import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/l10n/app_localizations_en.dart';
import 'package:opencode_remote_app/presentation/screens/connect/connect_error_message.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('connectErrorMessage', () {
    test('returns null when error is null', () {
      expect(connectErrorMessage(l10n, null), isNull);
    });

    test('maps AuthException', () {
      expect(
        connectErrorMessage(l10n, const AuthException('nope')),
        l10n.connectErrorAuth,
      );
    });

    test('maps NetworkException', () {
      expect(
        connectErrorMessage(l10n, const NetworkException('down')),
        l10n.connectErrorNetwork,
      );
    });

    test('maps TimeoutException', () {
      expect(
        connectErrorMessage(l10n, const TimeoutException('slow')),
        l10n.connectErrorTimeout,
      );
    });

    test('maps ServerException with message', () {
      expect(
        connectErrorMessage(
          l10n,
          const ServerException('boom', statusCode: 500),
        ),
        l10n.connectErrorServer('boom'),
      );
    });

    test('maps other AppException to generic', () {
      expect(
        connectErrorMessage(l10n, const ParseException('bad')),
        l10n.connectErrorGeneric,
      );
    });
  });
}
