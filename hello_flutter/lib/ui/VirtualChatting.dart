import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class VirtualChatting extends StatefulWidget {
  @override
  _VirtualChattingState createState() => _VirtualChattingState();
}

class _VirtualChattingState extends State<VirtualChatting> {

  var myRefSender;
  var myRefReceiver;
  var database;
  var _contMessage = TextEditingController();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
                child: StreamBuilder(
                  stream: myRefSender.onValue,
                  builder: (context,snapshot){
                    myRefSender.onValue.listen((event) {
                      var snapshot = event.snapshot;
                      var message = snapshot.value['ali-shahid'].keys;
                      for (var item in message) {
                        print('= $item');
                      }
                      //String value = snapshot.value['Relay1']['Data'];
                      //print(message);
                    });
                    return Container(
                      child: Text('Sender')
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _contMessage,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send
                    )
                  ),
                  Container(
                    child: InkWell(
                      onTap: () => sendMessage(),
                      child: Icon(Icons.send)
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
    myRefSender.child('ali-shahid').push().set({
      'message' : 'Hello Howo Are YOu',
      'sender': 'Ali',
    });
    myRefReceiver.child('shahid-ali').push().set({
      'message' : 'Hello Howo Are YOu',
      'sender': 'Ali',
    });
  }
}
