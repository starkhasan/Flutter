import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class SilverScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SilverScreen();
}

class _SilverScreen extends State<SilverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            centerTitle: true,
            floating: false,
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title : Text('Hello'),
              background: Image.network(
                'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
                fit: BoxFit.cover
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context,index){
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                );
              },
              childCount: 100,
            ),
          )
        ]
      )
    );
  }
}
