import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_chat/extensions/extensionFile.dart';

class ChatMedia extends StatefulWidget {
  final String path;
  final String name;
  final String dateTime;
  const ChatMedia({ Key? key ,required this.path,required this.name,required this.dateTime}) : super(key: key);
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.name[0].toUpperCase()+widget.name.substring(1)),
            Visibility(
              visible: widget.dateTime.isEmpty ? false : true,
              child: Text(
                widget.dateTime.isEmpty ? '' : widget.dateTime.formateDate,
                style: TextStyle(color: Colors.white,fontSize: 12,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal)
              )
            )
          ],
        ),
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