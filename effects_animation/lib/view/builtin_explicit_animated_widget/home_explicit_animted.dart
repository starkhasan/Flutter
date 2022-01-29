import 'package:flutter/material.dart';

class HomeExplicitAnimated extends StatelessWidget {
  const HomeExplicitAnimated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = [
      'Rotation Transition',
      'Slide Transition',
      'Size Transition',
      'Align Transition',
      'Fade Transition'
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
      case 2:
        Navigator.pushNamed(context, '/size_transition');
        break;
       case 3:
        Navigator.pushNamed(context, '/align_transition');
        break;
      case 4:
        Navigator.pushNamed(context, '/fade_transition');
        break;
      default:
    }
  }
}
