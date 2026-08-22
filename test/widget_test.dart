import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencode_remote_app/app.dart';
import 'package:opencode_remote_app/domain/providers/discovery_providers.dart';
import 'package:opencode_remote_app/services/discovered_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          discoveredServersProvider.overrideWith(
            (ref) => const Stream<List<DiscoveredServer>>.empty(),
          ),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Connect'), findsWidgets);
    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Servers on your network'), findsOneWidget);
  });
}
