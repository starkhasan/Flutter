import 'dart:math';

import 'package:flutter/material.dart';

class WidgetElementKeys extends StatefulWidget {
  const WidgetElementKeys({Key? key}) : super(key: key);

  @override
  _WidgetElementKeysState createState() => _WidgetElementKeysState();
}

class _WidgetElementKeysState extends State<WidgetElementKeys> {

  List<Widget> tiles = [
    Padding(key: UniqueKey(),padding: const EdgeInsets.all(5),child: const StatefulColorfulTile()),
    Padding(key: UniqueKey(),padding: const EdgeInsets.all(5),child: const StatefulColorfulTile())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Widget Element Example')
      ),
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(onPressed: swapColor,child: const Icon(Icons.add)),
    );
  }

  swapColor(){
    setState(() {
      tiles.insert(1,tiles.removeAt(0));
    });
  }
}


class StatefulColorfulTile extends StatefulWidget {
  const StatefulColorfulTile({Key? key}) : super(key: key);
  @override
  State<StatefulColorfulTile> createState() => _StatefulColorfulTileState();
}

class _StatefulColorfulTileState extends State<StatefulColorfulTile> {
  late Color myColor;

  @override
  void initState() {
    super.initState();
    myColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: const Padding(
        padding: EdgeInsets.all(70.0),
      )
    );
  }
}

