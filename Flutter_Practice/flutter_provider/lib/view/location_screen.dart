import 'package:flutter/material.dart';
import 'package:flutter_provider/model/counter_stream.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context){
    return StreamProvider<String>(
      create: (context) => CounterStream().positionStream,
      initialData: '',
      child: const MainStreamCounter()
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MainStreamCounter extends StatelessWidget{
  const MainStreamCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Counter Stream',style: TextStyle(fontSize: 14))),
      body: Consumer<String>(
        builder: (context, streamCount, child){
          return Center(
            child: Text(streamCount.toString()),
          );
        }
      ),
    );
  }

}
