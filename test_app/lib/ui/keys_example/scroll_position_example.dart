import 'package:flutter/material.dart';

class ScrollPositionExample extends StatefulWidget {
  const ScrollPositionExample({Key? key}) : super(key: key);

  @override
  _ScrollPositionExampleState createState() => _ScrollPositionExampleState();
}

class _ScrollPositionExampleState extends State<ScrollPositionExample> with SingleTickerProviderStateMixin{

  //late TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabChildren = const [
    ListItemChild(key: PageStorageKey<String>('Tab1')),
    ListItemChild(key: PageStorageKey<String>('Tab2')),
    ListItemChild(key: PageStorageKey<String>('Tab3')),
    ListItemChild(key: PageStorageKey<String>('Tab4'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scroll Position'),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            Expanded(
              child: Container(
                padding: EdgeInsets.zero,
                child: TabBarView(
                  children: tabChildren
                )
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 5,bottom: 5),
              child: const TabPageSelector(
                indicatorSize: 15.0,
              )
            )
          ]
        )
      )
    );
  }
}

class ListItemChild extends StatefulWidget {
  const ListItemChild({ Key? key }) : super(key: key);

  @override
  _ListItemChildState createState() => _ListItemChildState();
}

class _ListItemChildState extends State<ListItemChild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ListView.builder(
        key: PageStorageKey(widget.key).value,
        itemCount: 100,
        itemBuilder: (BuildContext contex,int index){
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1.0)]
            ),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(4),
            child: Text('Item $index')
          );
        }
      )
    );
  }
}
