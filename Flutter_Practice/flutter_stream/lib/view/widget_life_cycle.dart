import 'package:flutter/material.dart';
import 'package:flutter_stream/view/demo_screen.dart';

class WidgetLifeCycle extends StatefulWidget {
  const WidgetLifeCycle({Key? key}) : super(key: key);

  @override
  WidgetLifeCycleState createState() => WidgetLifeCycleState();
}

class WidgetLifeCycleState extends State<WidgetLifeCycle> with WidgetsBindingObserver {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoScreen(counter: count,onPress: counter),
    );
  }

   counter() {
    setState(() {
      count++;
    });
  }
}
