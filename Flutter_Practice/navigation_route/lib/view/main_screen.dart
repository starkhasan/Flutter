import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listScreen = ['Todo', 'UserDetails','Counter App'];
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Main')),
      body: ListView.builder(
        itemCount: listScreen.length,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onPageClick(context, index),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(listScreen[index],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }

  void onPageClick(BuildContext context, int index){
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home_screen');
        break;
      case 1:
        Navigator.pushNamed(context, '/user_registration');
        break;
      case 2:
        Navigator.pushNamed(context, '/counter_screen');
        break;
      default:
    }
  }
}
