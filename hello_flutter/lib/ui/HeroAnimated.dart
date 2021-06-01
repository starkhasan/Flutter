import 'package:flutter/material.dart';

class HeroAnimated extends StatefulWidget {
  @override
  _HeroAnimatedState createState() => _HeroAnimatedState();
}

class _HeroAnimatedState extends State<HeroAnimated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen())),
        child: Hero(tag: 'Image Hero', child: Image.network('https://picsum.photos/250?image=9'))
      )
    );
  }
}

class DetailsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Hero Example'),
      ),
      body: Container(
        color: Colors.black,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(child: Hero(tag: 'Image Hero',child: Image.network('https://picsum.photos/250?image=9'))),
        )
      )
    );
  }
}