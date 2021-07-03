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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InteractiveViewer(
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
          ),
          Visibility(
            visible: !fullScreen,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
              height: kToolbarHeight,
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back,color: Colors.white,)
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.name[0].toUpperCase()+widget.name.substring(1),
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: widget.dateTime.isEmpty ? false : true,
                        child: Text(
                          widget.dateTime.isEmpty ? '' : widget.dateTime.formateDate,
                          style: TextStyle(color: Colors.white,fontSize: 12,fontStyle: FontStyle.italic,fontWeight: FontWeight.normal)
                        )
                      )
                    ],
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}