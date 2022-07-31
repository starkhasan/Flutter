import 'package:flutter/material.dart';
import 'package:flutter_provider/view/changenotifier_value_example.dart';
import 'package:flutter_provider/view/comment_screen.dart';
import 'package:flutter_provider/view/counter_app.dart';
import 'package:flutter_provider/view/location_screen.dart';
import 'package:flutter_provider/view/multi_provider_example.dart';
import 'package:flutter_provider/view/multiprovider_counter_example.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenList = [
      'Counter App',
      'Comment',
      'Location Provider',
      'Multi Provider',
      'Multi Provider Counter',
      'ChangeNotifierProvider Value'
    ];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Home Screen')),
      body: ListView.builder(
        itemCount: screenList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: () => listClick(context, index),
            child: Card(
              child: ListTile(
                title: Text(screenList[index])
              )
            )
          );
        }
      )
    );
  }

  void listClick(BuildContext context,int index){
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterApp()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CommentScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MultiProviderExample()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MultiProviderCounterExample()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeNotifierValueExample()));
        break;
      default:
    }
  }
}
