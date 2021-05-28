import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat')
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
                    if(snapshot.hasData){
                      var notes = snapshot.data.snapshot.value;
                      return ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: notes.length,
                        itemBuilder: (context,index){
                          var key = notes.keys.elementAt(index);
                          Timer(Duration(milliseconds: 100), () => _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.easeOut));
                          return Align(
                            alignment: notes[key]['sender'] == sender ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: notes[key]['sender'] == sender ? Colors.green[100] : Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                ),
                              child: Text(
                                notes[key]['message'],
                                style: TextStyle(color: Colors.black)
                              )
                            )
                          );
                        }
                      );                      
                    }
                    return Container(child: Center(child:Text('No Message')));
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextField(
                        controller: _contMessage,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.send,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.grey)
                        ),
                        onSubmitted: (message) => sendMessage(),
                      )
                    )
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  InkWell(
                    onTap: () => sendMessage(),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink
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
