import 'dart:math';

import 'package:flutter/material.dart';

class KeySwapColor extends StatefulWidget {
  const KeySwapColor({Key? key}) : super(key: key);

  @override
  KeySwapColorState createState() => KeySwapColorState();
}

class KeySwapColorState extends State<KeySwapColor> {

  List<Widget> list = [
    Padding(key: UniqueKey(),padding: const EdgeInsets.all(20),child: const StatelessColorfulTile()),
    Padding(key: UniqueKey(),padding: const EdgeInsets.all(20),child: const StatelessColorfulTile())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Key Swap Color',style: TextStyle(fontSize: 14))),
      body: Row(mainAxisSize: MainAxisSize.min, children: list),
      floatingActionButton: FloatingActionButton(
        onPressed: () => swapColor(),
        child: const Icon(Icons.swap_horiz)
      )
    );
  }

  swapColor(){
    setState(() {
      list.insert(1, list.removeAt(0));
    });
  }
}
class StatelessColorfulTile extends StatelessWidget{
  const StatelessColorfulTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      width: 100,
      height: 100,
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
    );
  }
}
