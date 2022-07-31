import 'package:flutter/material.dart';
import 'package:flutter_keys/view/key_swap_color.dart';

class ScrollPositionExample extends StatefulWidget {
  const ScrollPositionExample({Key? key}) : super(key: key);

  @override
  ScrollPositionExampleState createState() => ScrollPositionExampleState();
}
class ScrollPositionExampleState extends State<ScrollPositionExample> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scroll Position', style: TextStyle(fontSize: 14)),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit))
          ]
        )
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          TabChild(key: PageStorageKey('One')),
          TabChild(key: PageStorageKey('Two'))
        ]
      ),
    );
  }
}

class TabChild extends StatelessWidget{
  const TabChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemBuilder: (context, index){
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KeySwapColor())),
          child: Card(
            child: ListTile(
              title: Text('Item $index'),
            )
          )
        );
      }
    );
  }
}