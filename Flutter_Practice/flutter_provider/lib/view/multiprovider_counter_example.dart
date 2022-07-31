import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/counter_provider.dart';
import 'package:flutter_provider/provider/random_number_provider.dart';
import 'package:provider/provider.dart';

class MultiProviderCounterExample extends StatelessWidget {
  const MultiProviderCounterExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => RandomNumberProvider())
      ],
      child: const MainScreenMultiCounter(),
    );
  }
}

class MainScreenMultiCounter extends StatefulWidget {
  const MainScreenMultiCounter({Key? key}) : super(key: key);

  @override
  MainScreenMultiCounterState createState() => MainScreenMultiCounterState();
}
class MainScreenMultiCounterState extends State<MainScreenMultiCounter>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('MultiProvider Counter',style: TextStyle(fontSize: 14))),
      body: Column(
        children: [
          Selector<RandomNumberProvider, int>(
            builder: (context, value, child){
              return Expanded(
                child: Container(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                  child: Center(child: Text('Random : ${value.toString()}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)))
                )
              );
            },
            selector: (context, provider) => provider.number
          ),
          Selector<CounterProvider, int>(
            builder: (context, value, child){
              return Expanded(
                child: Container(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                  child: Center(child: Text('Counter : ${value.toString()}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)))
                )
              );
            },
            selector: (context, provider) => provider.count
          )
        ]
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(heroTag: 'Random', onPressed: () => context.read<RandomNumberProvider>().getNumber(), isExtended: true,label: const Text('Random'),icon: const Icon(Icons.games)),
          const SizedBox(height: 10),
          FloatingActionButton.extended(heroTag: 'Counter', onPressed: () => context.read<CounterProvider>().increment(), isExtended: true,label: const Text('Counter'),icon: const Icon(Icons.add)),
        ]
      )
    );
  }
}