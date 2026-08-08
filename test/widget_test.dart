import 'package:flutter_test/flutter_test.dart';

import 'package:opencode_remote_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('mDNS Discovery'), findsOneWidget);
  });
}
