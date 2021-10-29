import 'package:flutter/material.dart';

class OutputPage extends StatefulWidget {
  const OutputPage({ Key? key }) : super(key: key);

  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Output',style: TextStyle(fontSize: 14)),
      ),
      body: Container(
        child: const Center(child: Text('Output')),
      ),
    );
  }
}