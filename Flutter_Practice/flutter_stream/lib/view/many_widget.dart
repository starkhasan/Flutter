import 'dart:math';

import 'package:flutter/material.dart';


class ManyWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MainWidgetState();
  }
}

class MainWidgetState extends State<ManyWidget>{

  var counter = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Hello Window')
            )
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  height: 100,
                  child: const Text('Item:')
                );
              },
              childCount: 50
            )
          )
        ]
      )
    );
  }

  void increment() => setState(() => counter++);
}