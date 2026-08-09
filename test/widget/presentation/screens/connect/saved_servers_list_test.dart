import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/core/errors/errors.dart';
import 'package:opencode_remote_app/data/models/saved_server.dart';
import 'package:opencode_remote_app/data/repositories/saved_server_repository.dart';
import 'package:opencode_remote_app/domain/providers/connection_providers.dart';
import 'package:opencode_remote_app/domain/providers/saved_server_providers.dart';
import 'package:opencode_remote_app/l10n/app_localizations.dart';
import 'package:opencode_remote_app/presentation/screens/connect/saved_servers_list.dart';

import '../../../../helpers/fake_saved_server_storage.dart';

void main() {
  /// Pumps [child] in a ProviderScope with [overrides] and l10n delegates.
  Future<void> pumpWithOverrides(
    WidgetTester tester,
    Widget child, {
    List<dynamic> overrides = const [],
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [...overrides],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: SingleChildScrollView(child: child)),
        ),
      ),
    );
  }

  final savedServer = SavedServer(
    id: 'srv1',
    host: '192.168.1.10',
    port: 4096,
    isDefault: true,
  );

  testWidgets('shows a message when no servers are saved', (tester) async {
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(FakeServerStorage(), FakeCredentialStorage()),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('Saved servers'), findsOneWidget);
    expect(find.text('No saved servers yet'), findsOneWidget);
  });

  testWidgets('renders one tile per saved server', (tester) async {
    final storage = FakeServerStorage([
      savedServer,
      SavedServer(id: 'srv2', host: 'server.local', port: 8080),
    ]);
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(storage, FakeCredentialStorage()),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('192.168.1.10:4096'), findsOneWidget);
    expect(find.text('server.local:8080'), findsOneWidget);
  });

  testWidgets('shows the default badge only on the default server', (
    tester,
  ) async {
    final storage = FakeServerStorage([
      savedServer,
      SavedServer(id: 'srv2', host: 'server.local', port: 8080),
    ]);
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(storage, FakeCredentialStorage()),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('shows an error widget with retry when loading fails', (
    tester,
  ) async {
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          _ThrowingSavedServerRepository(),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('Could not load saved servers'), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });

  testWidgets('tapping a tile reconnects with stored credentials', (
    tester,
  ) async {
    final credentials = FakeCredentialStorage();
    await credentials.save('srv1', (username: 'user', password: 'pass'));
    final recording = _RecordingConnection();

    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(FakeServerStorage([savedServer]), credentials),
        ),
        connectionProvider.overrideWith(() => recording),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('192.168.1.10:4096'));
    await tester.pumpAndSettle();

    expect(recording.lastConnect, isNotNull);
    expect(recording.lastConnect?.host, '192.168.1.10');
    expect(recording.lastConnect?.port, 4096);
    expect(recording.lastConnect?.username, 'user');
    expect(recording.lastConnect?.password, 'pass');
  });

  testWidgets('set as default via the overflow menu updates the default', (
    tester,
  ) async {
    final storage = FakeServerStorage([
      savedServer,
      SavedServer(id: 'srv2', host: 'server.local', port: 8080),
    ]);
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(storage, FakeCredentialStorage()),
        ),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set as default'));
    await tester.pumpAndSettle();

    final servers = await storage.getAll();
    expect(servers.firstWhere((s) => s.id == 'srv2').isDefault, isTrue);
    expect(servers.firstWhere((s) => s.id == 'srv1').isDefault, isFalse);
    expect(find.text('Default server updated'), findsOneWidget);
  });

  testWidgets('delete via the overflow menu removes the tile', (tester) async {
    final storage = FakeServerStorage([savedServer]);
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(storage, FakeCredentialStorage()),
        ),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('192.168.1.10:4096'), findsNothing);
    expect(find.text('No saved servers yet'), findsOneWidget);
    expect(find.text('Server removed'), findsOneWidget);
  });

  testWidgets('swipe to dismiss deletes the server', (tester) async {
    final storage = FakeServerStorage([savedServer]);
    await pumpWithOverrides(
      tester,
      const SavedServersList(),
      overrides: [
        savedServerRepositoryProvider.overrideWithValue(
          SavedServerRepository(storage, FakeCredentialStorage()),
        ),
      ],
    );
    await tester.pumpAndSettle();

    await tester.drag(find.text('192.168.1.10:4096'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('192.168.1.10:4096'), findsNothing);
    expect(await storage.getAll(), isEmpty);
    expect(find.text('Server removed'), findsOneWidget);
  });
}

class _ThrowingSavedServerRepository extends SavedServerRepository {
  _ThrowingSavedServerRepository()
    : super(FakeServerStorage(), FakeCredentialStorage());

  @override
  Future<List<SavedServer>> getAll() {
    return Future.error(const CacheException('boom'));
  }
}

class _RecordingConnection extends Connection {
  ({String host, int port, String? username, String? password})? lastConnect;

  @override
  AppConnectionState build() => const AppConnectionState();

  @override
  Future<void> connect({
    required String host,
    required int port,
    String? username,
    String? password,
  }) async {
    lastConnect = (
      host: host,
      port: port,
      username: username,
      password: password,
    );
  }
}
