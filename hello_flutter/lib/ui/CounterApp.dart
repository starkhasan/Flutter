import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/Counter.dart';
import 'package:provider/provider.dart';

class CounterApp extends StatefulWidget {
  @override
  _CounterApp createState() => _CounterApp();
}

class _CounterApp extends State<CounterApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MainApplication(),
    );
  }
}

class MainApplication extends StatefulWidget {
  @override
  _MainApplication createState() => _MainApplication();
}

class _MainApplication extends State<MainApplication> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Counter>(context,listen: true);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Ali Hasan')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.increment(),
        child: Icon(Icons.phone),
      ),
      body: Container(
        child: Center(child: Text(provider.count.toString())),
      ),
    );
  }
}
