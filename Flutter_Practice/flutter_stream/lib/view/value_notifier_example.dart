import 'package:flutter/material.dart';

class ValueNotifierExample extends StatelessWidget {
  const ValueNotifierExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> counter = ValueNotifier<int>(0);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Value Notifier Example',style: TextStyle(fontSize: 14))
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: counter,
          builder: (_, value, __){
            return Text('$value',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold));
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value += 1,
        child: const Icon(Icons.add)
      )
    );
  }
}
