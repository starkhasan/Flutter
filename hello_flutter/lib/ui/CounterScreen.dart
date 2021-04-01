import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/Counter.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, counter, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => counter.increment(),
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text('Counter'),
            ),
            body: Container(
              child: Center(
                child: Text('Incremnt Counter ${counter.count.toString()}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
