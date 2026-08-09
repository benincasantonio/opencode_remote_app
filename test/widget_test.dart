import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:opencode_remote_app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Connect'), findsWidgets);
    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Open mDNS Discovery'), findsOneWidget);
  });
}
