import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({ Key? key }) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Input',style: TextStyle(fontSize: 14)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Add Input'),
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Center(child: Text('Input'))
      ),
    );
  }
}

class MainInputScreen extends StatefulWidget {
  const MainInputScreen({ Key? key }) : super(key: key);

  @override
  _MainInputScreenState createState() => _MainInputScreenState();
}

class _MainInputScreenState extends State<MainInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}