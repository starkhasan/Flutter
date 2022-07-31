import 'package:flutter/material.dart';
import 'package:flutter_keys/view/key_swap_color.dart';
import 'package:flutter_keys/view/key_swap_color_stateful.dart';
import 'package:flutter_keys/view/scroll_position_example.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = [
      'Swap Color Stateless',
      'Swap Color Stateful',
      'Scroll Position'
    ];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Home',style: TextStyle(fontSize:14))),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: listScreen.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index){
            return InkWell(
              onTap: () => onClickNavigation(context, index),
              child: Card(
                child: ListTile(
                  title: Text(listScreen[index])
                )
              )
            );
          }
        ),
      ),
    );
  }

  void onClickNavigation(BuildContext context,int index){
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const KeySwapColor()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const KeySwapColorStateful()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScrollPositionExample()));
        break;
      default:
    }
  }
}
