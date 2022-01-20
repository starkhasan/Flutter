import 'package:flutter/material.dart';

class WidgetTestingScreen extends StatefulWidget {
  const WidgetTestingScreen({ Key? key }) : super(key: key);

  @override
  _WidgetTestingScreenState createState() => _WidgetTestingScreenState();
}

class _WidgetTestingScreenState extends State<WidgetTestingScreen> {

  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Widget Testing Screen',style: TextStyle(fontSize: 14)),
      ),
      body: Center(
        child: Text('$_counter')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: const Icon(Icons.add)
      )
    );
  }

  incrementCounter(){
    setState(() {
      _counter++;
    });
  }
}