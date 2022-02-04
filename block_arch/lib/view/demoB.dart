import 'package:flutter/material.dart';

class DemoB extends StatefulWidget {
  const DemoB({Key? key}) : super(key: key);

  @override
  _DemoBState createState() => _DemoBState();
}

class _DemoBState extends State<DemoB> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('DemoB')),
      body: Center(
        child: Text('$count')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add)
      )
    );
  }

  void increment(){
    setState(() {
      count++;
    });
  }
}
