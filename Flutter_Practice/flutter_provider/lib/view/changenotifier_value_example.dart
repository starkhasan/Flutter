import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/counter_provider.dart';
import 'package:provider/provider.dart';

class ChangeNotifierValueExample extends StatefulWidget {
  const ChangeNotifierValueExample({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierValueExample> createState() => _ChangeNotifierValueExampleState();
}

class _ChangeNotifierValueExampleState extends State<ChangeNotifierValueExample> {

  late CounterProvider counterProvider;

  @override
  void initState() {
    counterProvider = CounterProvider();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterProvider>.value(
      value: counterProvider,
      child: const MainScreen()
    );
  }
}

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Consumer<CounterProvider>(
      builder: (context, provider, child){
        return Scaffold(
          appBar: AppBar(centerTitle: true,title: const Text('ProviderValue',style: TextStyle(fontSize: 14))),
          body: Center(
            child: Text('Counter : ${provider.count.toString()}')
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => provider.increment(),
            child: const Icon(Icons.add)
          )
        );
      }
    );
  }
}
