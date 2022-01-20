import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/view/widget_testing_screen.dart';

void main() {
  //Use testingWidget function provided by the flutter_test package to define a test
  //testWdigets functions allows  you to define a widget test and creates a WdigetTester to work with
  //
  //

  //Here you need to wrap your widget with the MaterialApp because you are using Scaffold
  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Counter increment test', (WidgetTester tester) async {
    //pumpWidget() Renders the UI from the given widget
    await tester
        .pumpWidget(createWidgetForTesting(child: const WidgetTestingScreen()));
    //After the initial call to pumpWidget() the WidgetTester provides additional ways to rebuilt the same widget. This is useful if you are working with a StatefulWidget or animations
    //to rebuilt the widget in test environment we will call the pump() function

    //tester.pumpSettle()
    //Repeatedly call pump() with the given duration until there are no longer any frames scheduled. This essentiallywaits forall animations to complete.
    // Create the Finders.

    expect(find.text("0"), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.

    //performing the tap on widget and check the counter
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text("0"), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
