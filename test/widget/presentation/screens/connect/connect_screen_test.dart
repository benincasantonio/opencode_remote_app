import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/datasources/server_datasource.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';
import 'package:opencode_remote_app/data/models/server_health.dart';
import 'package:opencode_remote_app/data/repositories/server_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/discovery_providers.dart';
import 'package:opencode_remote_app/domain/providers/server_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/connect/connect_screen.dart';
import 'package:opencode_remote_app/presentation/screens/connect/manual_connect_widget.dart';
import 'package:opencode_remote_app/presentation/widgets/connection_badge/connection_status.dart';
import 'package:opencode_remote_app/services/discovered_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    // The boot auto-connect reads stored credentials via the secure storage
    // platform channel, which never resolves in widget tests. Answer with
    // "nothing stored" so the flow can proceed.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
          (call) async => null,
        );
  });

  /// Pumps [child] in a ProviderScope with [overrides] and l10n delegates.
  ///
  /// Always overrides [discoveredServersProvider] with an empty fake stream so
  /// widget tests never invoke the Bonsoir platform plugin; pass your own
  /// [discoveredServersProvider] override in [overrides] to replace it.
  Future<void> pumpWithOverrides(
    WidgetTester tester,
    Widget child, {
    List<dynamic> overrides = const [],
  }) {
    final hasDiscovery = overrides.any(
      (o) => identical((o as dynamic).origin, discoveredServersProvider),
    );
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (!hasDiscovery)
            discoveredServersProvider.overrideWith(
              (ref) => const Stream<List<DiscoveredServer>>.empty(),
            ),
          ...overrides,
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: child,
        ),
      ),
    );
  }

  testWidgets('ConnectScreen shows manual form fields', (tester) async {
    await pumpWithOverrides(tester, const ConnectScreen());
    await tester.pumpAndSettle();

    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Port'), findsOneWidget);
    expect(find.text('Username (optional)'), findsOneWidget);
    expect(find.text('Password (optional)'), findsOneWidget);
    expect(find.text('Connect'), findsWidgets);
    expect(find.text('Servers on your network'), findsOneWidget);
    expect(find.text('Searching for servers…'), findsOneWidget);
  });

  testWidgets('ConnectScreen shows sections in Saved → LAN → manual order', (
    tester,
  ) async {
    final server = SavedServer(
      id: 's1',
      host: '192.168.1.10',
      port: 4096,
      isDefault: true,
    );
    SharedPreferences.setMockInitialValues({
      'saved_servers_v1': jsonEncode([server.toJson()]),
    });

    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        discoveredServersProvider.overrideWith(
          (ref) => Stream.value(const [
            DiscoveredServer(
              name: 'opencode-4096',
              host: '10.0.0.5',
              port: 4096,
            ),
          ]),
        ),
      ],
    );
    await tester.pumpAndSettle();

    final savedY = tester.getTopLeft(find.text('Saved servers')).dy;
    final lanY = tester.getTopLeft(find.text('Servers on your network')).dy;
    final manualY = tester.getTopLeft(find.text('Host')).dy;

    expect(savedY, lessThan(lanY));
    expect(lanY, lessThan(manualY));
  });

  testWidgets('ConnectScreen shows auth error from connection state', (
    tester,
  ) async {
    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        connectionProvider.overrideWithValue(
          const AppConnectionState(
            status: ConnectionStatus.error,
            error: AuthException('Unauthorized', statusCode: 401),
          ),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Authentication failed. Check username and password.'),
      findsOneWidget,
    );
  });

  testWidgets('connection error renders above all sections, not in the form', (
    tester,
  ) async {
    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        connectionProvider.overrideWithValue(
          const AppConnectionState(
            status: ConnectionStatus.error,
            error: AuthException('Unauthorized', statusCode: 401),
          ),
        ),
      ],
    );
    await tester.pumpAndSettle();

    final error = find.text(
      'Authentication failed. Check username and password.',
    );
    final errorY = tester.getTopLeft(error).dy;
    final savedY = tester.getTopLeft(find.text('Saved servers')).dy;
    expect(errorY, lessThan(savedY));

    expect(
      find.descendant(
        of: find.byType(ManualConnectWidget),
        matching: find.text(
          'Authentication failed. Check username and password.',
        ),
      ),
      findsNothing,
    );
  });

  testWidgets('ConnectScreen disables connect while connecting', (
    tester,
  ) async {
    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        connectionProvider.overrideWithValue(
          const AppConnectionState(status: ConnectionStatus.connecting),
        ),
      ],
    );
    await tester.pump();

    final button = tester.widget<FilledButton>(
      find.ancestor(
        of: find.byType(CircularProgressIndicator),
        matching: find.byType(FilledButton),
      ),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('ConnectScreen shows boot loading state while auto-connecting', (
    tester,
  ) async {
    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        connectionProvider.overrideWithValue(
          const AppConnectionState(bootInProgress: true),
        ),
      ],
    );
    await tester.pump();

    expect(find.text('Reconnecting…'), findsOneWidget);
    expect(find.text('Host'), findsNothing);
    expect(find.text('Saved servers'), findsNothing);
    expect(find.text('Servers on your network'), findsNothing);
  });

  testWidgets('ConnectScreen lists saved servers for quick reconnect', (
    tester,
  ) async {
    final servers = [
      SavedServer(id: 's1', host: '192.168.1.10', port: 4096, isDefault: true),
      SavedServer(id: 's2', host: 'server.local', port: 4096),
    ];
    SharedPreferences.setMockInitialValues({
      'saved_servers_v1': jsonEncode([
        for (final server in servers) server.toJson(),
      ]),
    });

    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        connectionProvider.overrideWithValue(const AppConnectionState()),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('192.168.1.10:4096'), findsOneWidget);
    expect(find.text('server.local:4096'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('saved and discovered entries remain independently visible', (
    tester,
  ) async {
    final server = SavedServer(
      id: 's1',
      host: '192.168.1.10',
      port: 4096,
      isDefault: true,
    );
    SharedPreferences.setMockInitialValues({
      'saved_servers_v1': jsonEncode([server.toJson()]),
    });

    await pumpWithOverrides(
      tester,
      const ConnectScreen(),
      overrides: [
        discoveredServersProvider.overrideWith(
          (ref) => Stream.value(const [
            DiscoveredServer(
              name: 'opencode-4096',
              host: '192.168.1.10',
              port: 4096,
            ),
          ]),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(
      find.text('192.168.1.10:4096'),
      findsNWidgets(2),
      reason: 'saved and discovered sections are independent',
    );
  });

  testWidgets(
    'ConnectScreen shows an error when the saved server is unreachable',
    (tester) async {
      final server = SavedServer(
        id: 's1',
        host: '192.168.1.10',
        port: 4096,
        isDefault: true,
      );
      SharedPreferences.setMockInitialValues({
        'saved_servers_v1': jsonEncode([server.toJson()]),
      });

      await pumpWithOverrides(
        tester,
        const ConnectScreen(),
        overrides: [
          serverRepositoryProvider.overrideWithValue(
            _FailingServerRepository(
              error: const NetworkException('Connection refused'),
            ),
          ),
        ],
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Could not reach the server. Check host and port.'),
        findsOneWidget,
      );
      expect(
        find.text('192.168.1.10:4096'),
        findsOneWidget,
        reason: 'saved server stays listed so the user can retry',
      );
    },
  );
}

class _FailingServerRepository extends ServerRepository {
  _FailingServerRepository({required this.error})
    : super(ServerDatasource(Dio()));

  final AppException error;

  @override
  Future<ServerHealth> getHealth({CancelToken? cancelToken}) =>
      Future.error(error);
}
