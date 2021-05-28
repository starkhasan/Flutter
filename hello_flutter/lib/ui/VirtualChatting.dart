import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/CustomChatBubble.dart';

class VirtualChatting extends StatefulWidget {
  @override
  _VirtualChattingState createState() => _VirtualChattingState();
}

class _VirtualChattingState extends State<VirtualChatting> {

  var myRefSender;
  var myRefReceiver;
  var database;
  var _contMessage = TextEditingController();
  var snapShot;
  var sender = 'Shahid';
  var _scrollController = ScrollController();

  @override
  void initState() {
    Firebase.initializeApp();
    database = FirebaseDatabase.instance;
    myRefSender = database.reference().child('messages');
    myRefReceiver = database.reference().child('messages');
    super.initState();
  }

  scrollToBottom() {
    Timer(Duration(milliseconds: 100), () => _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Chat'),
        brightness: Brightness.dark
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
                child: StreamBuilder(
                  stream: myRefSender.child('ali-shahid').onValue,
                  builder: (context,snapshot){
                    if(!snapshot.hasData || snapshot.hasError){
                      return Container(child: Center(child:  CircularProgressIndicator(color: Colors.blue,strokeWidth: 3))); 
                    }else if(snapshot.hasData && snapshot.data.snapshot.value != null){
                      scrollToBottom();
                      var notes = snapshot.data.snapshot.value;
                      return ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: notes.length,
                        itemBuilder: (context,index){
                          var key = notes.keys.elementAt(index);
                          return Align(
                            alignment: notes[key]['sender'] == sender ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
                              child: CustomPaint(
                                  painter: CustomChatBubble(color: notes[key]['sender'] == sender ? Colors.blue : Colors.white,isSender: notes[key]['sender'] == sender ? true : false),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                    decoration: BoxDecoration(
                                      color: notes[key]['sender'] == sender ? Colors.blue : Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                  child: Text(
                                    notes[key]['message'],
                                    style: TextStyle(color: notes[key]['sender'] == sender ? Colors.white : Colors.black)
                                  )
                                )
                              )
                            )
                          );
                        }
                      );                    
                    }else
                      return Container(child: Center(child:Text('No Message',style: TextStyle(color:  Colors.black))));
                  }
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      child: TextField(
                        controller: _contMessage,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.grey[400])
                        )
                      )
                    )
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  InkWell(
                    onTap: () => {
                      sendMessage(),
                      scrollToBottom()
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue
                      ),
                      child: Icon(Icons.send,color: Colors.white)
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  sendMessage(){
    if(_contMessage.text.isNotEmpty){
      myRefSender.child('ali-shahid').push().set({
        'message' : _contMessage.text.toString(),
        'sender': sender,
      });
      myRefReceiver.child('shahid-ali').push().set({
        'message' : _contMessage.text.toString(),
        'sender': sender,
      });
    }
    _contMessage.clear();
  }
}
