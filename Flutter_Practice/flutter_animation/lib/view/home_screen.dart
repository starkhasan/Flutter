import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = ['Container Transform'];
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Home')),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: listScreen.length,
        itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => onClick(context, index),
          child: Card(
            child: ListTile(
              title: Text(listScreen[index]),
            ),
          ),
        );
      }),
    );
  }

  onClick(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/container_transform');
        break;
      default:
    }
  }
}
