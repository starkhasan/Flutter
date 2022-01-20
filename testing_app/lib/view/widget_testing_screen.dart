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
        title: const Text('Counter Testing',style: TextStyle(fontSize: 14)),
      ),
      body: Center(
        child: Text('$_counter')
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: incrementCounter,
            child: const Icon(Icons.add)
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: decrementCounter,
            child: const Icon(Icons.remove)
          )
        ]
      )
    );
  }

  incrementCounter(){
    setState(() {
      _counter++;
    });
  }

  decrementCounter(){
    setState(() {
      _counter--;
    });
  }

}