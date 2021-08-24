import 'package:block_arch/bloc/first_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FirstBloc(),
      child: const FirstScreen()
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('First'),
      ),
      body: BlocBuilder<FirstBloc, int>(
        builder: (context,count){
          return Center(
            child: Text(
              '$count',
              style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
            ),
          );
        }
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<FirstBloc>().add(CounterEvent.increment),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<FirstBloc>().add(CounterEvent.decrement),
            )
          )
        ]
      ),
    );
  }
}