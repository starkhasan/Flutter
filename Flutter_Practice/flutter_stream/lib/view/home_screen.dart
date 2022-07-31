import 'package:flutter/material.dart';
import 'package:flutter_stream/view/many_widget.dart';
import 'package:flutter_stream/view/single_stream_counter.dart';
import 'package:flutter_stream/view/stream_rxdart_example.dart';
import 'package:flutter_stream/view/todo_screen.dart';
import 'package:flutter_stream/view/value_notifier_example.dart';
import 'package:flutter_stream/view/widget_life_cycle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = [
      'Single Stream',
      'Stream RxDart',
      'Todos',
      'Value Notifier Example',
      'Life Cycle',
      'Many Widget'
    ];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: listScreen.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index){
            return InkWell(
              onTap: () => onClick(context, index),
              child: Card(
                child: ListTile(
                  title: Text(listScreen[index])
                )
              )
            );
          }
        )
      )
    );
  }

  onClick(BuildContext context, int index){
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleStreamCounter()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const StreamRxDart()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ValueNotifierExample()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WidgetLifeCycle()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ManyWidget()));
        break;
      default:
    }
  }
}
