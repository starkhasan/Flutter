import 'dart:math';

import 'package:flutter/material.dart';

class SliverWidgetPage extends StatefulWidget {
  const SliverWidgetPage({ Key? key }) : super(key: key);

  @override
  _SliverWidgetPageState createState() => _SliverWidgetPageState();
}

class _SliverWidgetPageState extends State<SliverWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: const Color(0xFF323232)
        )       
      ),
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: false,
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('SliverWidget Page'),
              stretchModes: const [StretchMode.fadeTitle],
              centerTitle: true,
              background: Image.network('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ',fit: BoxFit.cover),
            )
          ),
          SliverGrid.extent(
            maxCrossAxisExtent: 200,
            children: [
              Container(color: Colors.red, height: 150.0),
              Container(color: Colors.purple, height: 150.0),
              Container(color: Colors.green, height: 150.0),
              Container(color: Colors.orange, height: 150.0),
              Container(color: Colors.yellow, height: 150.0),
              Container(color: Colors.pink, height: 150.0),
              Container(color: Colors.cyan, height: 150.0),
              Container(color: Colors.indigo, height: 150.0),
              Container(color: Colors.blue, height: 150.0),
              Container(color: Colors.red, height: 150.0),
              Container(color: Colors.purple, height: 150.0),
              Container(color: Colors.green, height: 150.0),
              Container(color: Colors.orange, height: 150.0),
              Container(color: Colors.yellow, height: 150.0),
              Container(color: Colors.pink, height: 150.0),
              Container(color: Colors.cyan, height: 150.0),
              Container(color: Colors.indigo, height: 150.0),
              Container(color: Colors.blue, height: 150.0),
              Container(color: Colors.red, height: 150.0),
              Container(color: Colors.purple, height: 150.0),
              Container(color: Colors.green, height: 150.0),
              Container(color: Colors.orange, height: 150.0),
              Container(color: Colors.yellow, height: 150.0),
              Container(color: Colors.pink, height: 150.0),
              Container(color: Colors.cyan, height: 150.0),
              Container(color: Colors.indigo, height: 150.0),
              Container(color: Colors.blue, height: 150.0),
              Container(color: Colors.red, height: 150.0),
              Container(color: Colors.purple, height: 150.0),
              Container(color: Colors.green, height: 150.0),
              Container(color: Colors.orange, height: 150.0),
              Container(color: Colors.yellow, height: 150.0),
              Container(color: Colors.pink, height: 150.0),
              Container(color: Colors.cyan, height: 150.0),
              Container(color: Colors.indigo, height: 150.0),
              Container(color: Colors.blue, height: 150.0),
              Container(color: Colors.red, height: 150.0),
              Container(color: Colors.purple, height: 150.0),
              Container(color: Colors.green, height: 150.0),
              Container(color: Colors.orange, height: 150.0),
              Container(color: Colors.yellow, height: 150.0),
              Container(color: Colors.pink, height: 150.0),
              Container(color: Colors.cyan, height: 150.0),
              Container(color: Colors.indigo, height: 150.0),
              Container(color: Colors.blue, height: 150.0),
              Container(color: Colors.blue, height: 150.0)
            ]
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return  Container(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  height: 150.0);
              },
              childCount: 100
            )
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context,int index){
                return Container(color: Colors.primaries[Random().nextInt(Colors.primaries.length)],height: 80);
              },
              childCount: 30
            )
          )
        ] 
      )
    );
  }
}