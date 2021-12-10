import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListSlidable extends StatefulWidget {
  const ListSlidable({ Key? key }) : super(key: key);

  @override
  _ListSlidableState createState() => _ListSlidableState();
}

class _ListSlidableState extends State<ListSlidable> {

  var listIndex = [];

  @override
  void initState() {
    super.initState();
    List.generate(15, (index) => listIndex.add('Index ${index+1}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('List Slidable'),
      ),
      body: ListView.separated(
        itemCount: listIndex.length,
        itemBuilder: (BuildContext context,int index){
          //using there the flutter_slidable package
          return Slidable(
            key: const ValueKey(0),
            dragStartBehavior: DragStartBehavior.start,
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  spacing: 0.0,
                  icon: Icons.delete,
                  onPressed: (BuildContext context) { 
                    setState(() {
                      listIndex.removeAt(index);
                    });
                  }
                )
              ]
            ),
            child: const ListTile(title: Text('Slide Me')),
          );
        },
        separatorBuilder: (context,index){
          return const Divider(height: 1.5,thickness: 1.5,color: Colors.white);
        }
      ),
    );
  }
}