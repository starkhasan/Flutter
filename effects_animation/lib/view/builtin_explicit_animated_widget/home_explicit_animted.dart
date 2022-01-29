import 'package:flutter/material.dart';

class HomeExplicitAnimated extends StatelessWidget {
  const HomeExplicitAnimated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = [
      'Rotation Transition',
      'Slide Transition'
    ];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Explit Built Animation',style: TextStyle(fontSize: 14))),
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
        Navigator.pushNamed(context, '/rotation_transition');
        break;
      case 1:
        Navigator.pushNamed(context, '/slide_transition');
        break;
      default:
    }
  }
}
