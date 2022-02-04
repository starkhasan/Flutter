import 'package:flutter/material.dart';
import 'package:block_arch/view/demoB.dart';

class DemoA extends StatefulWidget {
  const DemoA({Key? key}) : super(key: key);

  @override
  State<DemoA> createState() => _DemoAState();
}

class _DemoAState extends State<DemoA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('DemoA')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoB())),
          child: const Text(' => ')
        )
      )
    );
  }
}
