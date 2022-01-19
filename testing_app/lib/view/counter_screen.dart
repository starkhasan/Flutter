import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/prvoider/counter_provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterProvider>(
      create: (context) => CounterProvider(),
      child: Consumer<CounterProvider>(
        builder: (context, provider,child){
          return Scaffold(
            appBar: AppBar(centerTitle: true,title: const Text('Counter',style: TextStyle(fontSize: 14))),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('You clicked ${provider.counter}')
                ]
              )
            ),
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () => provider.increment(),
                  child: const Icon(Icons.add)
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () => provider.decrement(),
                  child: const Icon(Icons.remove)
                )
              ]
            )
          );
        }
      )
    );
  }
}
