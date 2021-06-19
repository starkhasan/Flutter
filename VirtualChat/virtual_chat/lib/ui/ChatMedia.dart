import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatMedia extends StatefulWidget {
  final String path;
  final String name;
  const ChatMedia({ Key? key ,required this.path,required this.name}) : super(key: key);
  @override
  _ChatMedia createState() => _ChatMedia();
}
class _ChatMedia extends State<ChatMedia>{
  
  var fullScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !fullScreen 
      ? AppBar(
        centerTitle: false,
        title: Text(widget.name[0].toUpperCase()+widget.name.substring(1)),
        backgroundColor: Colors.black,
        brightness: Brightness.dark
      )
      : null,
      body: InteractiveViewer(
        child: GestureDetector(
          onDoubleTap: () => {
            setState((){
              fullScreen ? SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values) : SystemChrome.setEnabledSystemUIOverlays([]);
              fullScreen = fullScreen ? false : true;
            })
          },
          child: Container(
            color: Colors.black,
            child: Center(
              child: Hero(
                tag: 'Image Hero',
                child: Image.network(widget.path)
              )
            )
          )
        )
      )
    );
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}