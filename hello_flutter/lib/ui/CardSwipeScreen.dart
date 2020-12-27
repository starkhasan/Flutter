import 'package:flutter/material.dart';

class CardSwipeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardSwipeScreen();
}

class _CardSwipeScreen extends State<CardSwipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Swipe"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('Card Swipe'),
        ),
      ),
    );
  }
}
