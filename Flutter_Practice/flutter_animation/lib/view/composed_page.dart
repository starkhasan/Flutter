import 'package:flutter/material.dart';

class ComposedPage extends StatelessWidget {
  const ComposedPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Composed Mail'),),
      body: Container(),
    );
  }
}