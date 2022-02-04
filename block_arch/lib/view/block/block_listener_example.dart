import 'package:block_arch/bloc/first_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListenerExample extends StatelessWidget {
  const BlocListenerExample({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FirstBloc(),
      child: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bloc Listener')
      ),
      body: BlocListener<FirstBloc,int>(
        listener: (context, state){
          if(state.isEven) showSnackBar("Even Number",context);
        },
        child: BlocBuilder<FirstBloc,int>(
          builder: (context, state){
            return Center(
              child: Text('$state'),
            );
          }
        ),
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
      )
    );
  }

  void showSnackBar(String message,BuildContext context){
    var snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}