import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = [
      'Implicit Animation',
      'Implicit Tween Animation',
      'Explicit Built Animation',
      'Staggered Animation'
    ];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Home',style: TextStyle(fontSize: 14))),
      body: ListView.builder(
        itemCount: listScreen.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => clickItem(context,index),
            child: Card(
              child: ListTile(
                title: Text(listScreen[index])
              )
            )
          );
        }
      )
    );
  }

  void clickItem(BuildContext context, int index){
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/implicit_animation');
        break;
      case 1:
        Navigator.pushNamed(context, '/implicit_tween_animation');
        break;
      case 2:
        Navigator.pushNamed(context, '/explicit_built_animation');
        break;
      case 3:
        Navigator.pushNamed(context, '/staggered_animation');
        break;
      default:
    }
  }
}
