import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/view/authentication_screen.dart';

void main() {
  testWidgets('Authentication Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AuthenticationScreen()));
    var emailText = find.byKey(const Key('EmailKey'));
    await tester.enterText(emailText, 'Ali Hasan');

    var button = find.text("Continue");
    await tester.tap(button);
    await tester.pump();
    expect(find.text('Abdul Shahid'), findsOneWidget);
  });
}
