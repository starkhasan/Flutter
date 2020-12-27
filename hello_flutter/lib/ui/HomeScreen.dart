import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/ExpandableCardList.dart';
import 'package:hello_flutter/ui/LandingPage.dart';
import 'package:hello_flutter/ui/SwipeDeleteScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<String> itemsList = [
    'Landing Screen',
    'Swipe Delete',
    'Expandable Cards'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => print('Tap on Add Check'),
            icon: Icon(Icons.library_add_check, color: Colors.white),
          ),
          IconButton(
            onPressed: () => print('Tap on Cart'),
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: itemsList.length,
          itemBuilder: (context,index){
            return Card(
              child: InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SwipeDeleteScreen()));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandableCardList()));
                      break;
                    default:
                  }
                },
                child: ListTile(
                  title: Text(itemsList[index]),
                ),
              )
            );
          },
        ),
      ),
    );
  }
}
