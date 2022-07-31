import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MainScrren(),
    );
  }
}

class MainScrren extends StatelessWidget {
  const MainScrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Counter App', style: TextStyle(fontSize: 14))
      ),
      body: Consumer<CounterProvider>(
        builder: (context, provider, child){
          return Center(child: Text('${provider.count}',style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)));
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CounterProvider>(context,listen: false).increment(),
        child: const Icon(Icons.add)
      )
    );
  }
}
