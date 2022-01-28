import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = ['Implicit Animation'];
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
            ),
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
      default:
    }
  }
}
