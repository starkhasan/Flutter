import 'package:flutter/material.dart';

class ChatMedia extends StatelessWidget {
  final String path;
  final String name;
  const ChatMedia({ Key? key ,required this.path,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(name[0].toUpperCase()+name.substring(1)),
        backgroundColor: Colors.black,
        brightness: Brightness.dark
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Hero(
            tag: 'Image Hero',
            child: Image.network(path),
          )
        )
      )
    );
  }
}