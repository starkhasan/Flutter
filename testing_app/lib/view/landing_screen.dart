import 'package:flutter/material.dart';
import 'package:testing_app/view/counter_screen.dart';
import 'package:testing_app/view/home_screen.dart';
import 'package:testing_app/view/widget_testing_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({ Key? key }) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  var screen = const ['Favorite List','Counter Application','Counter Testing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Landing Page',style: TextStyle(fontSize: 14))),
      body: ListView.builder(
        itemCount: screen.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: () => onClick(context, index),
            child: Card(
              child: ListTile(
                title: Text(screen[index])
              )
            )
          );
        }
      )
    );
  }

  onClick(BuildContext context,int index){
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WidgetTestingScreen()));
        break;
      default:
        break;
    }
  }
}