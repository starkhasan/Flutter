import 'package:flutter/material.dart';
import 'dart:math' as math;

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Counter')),
      body: Center(child: Text('Counter = $count')),
      floatingActionButton: FloatingActionButton(onPressed: () => setState(() => count++), child: const Icon(Icons.add)),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => showSnackBar('Click Here to call', context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.call,color: Colors.white),
                  Text('CALL',style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            InkWell(
              onTap: () => showSnackBar('Click here to show Route', context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(angle: math.pi / 4,child: const Icon(Icons.navigation,color: Colors.white)),
                  const Text('ROUTE',style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            InkWell(
              onTap: () => showSnackBar('Click Here to Share', context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.share,color: Colors.white),
                  Text('SHARE',style: TextStyle(color: Colors.white))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackBar(String message, BuildContext context){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
