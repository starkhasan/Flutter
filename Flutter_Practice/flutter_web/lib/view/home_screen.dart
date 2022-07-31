import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Home Screen')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Container(color: Colors.pink,child: const Icon(Icons.add))),
              Expanded(child: Container(color: Colors.teal, child: const Text('Ali hasa where are you from, i am from wali  ganj arrah bhojpur bihar, OK')))
            ],
          )
        ],
      )
    );
  }
}
