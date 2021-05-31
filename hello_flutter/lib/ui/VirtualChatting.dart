import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/CustomChatBubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';


class VirtualChatting extends StatefulWidget {
  final String senderUser;
  final String senderReceiver;
  final String receiver;
  VirtualChatting({@required this.senderUser,@required this.senderReceiver,@required this.receiver});
  @override
  _VirtualChattingState createState() => _VirtualChattingState();
}

class _VirtualChattingState extends State<VirtualChatting> {

  var myRefSender;
  var myRefReceiver;
  var firebaseStore;
  var database;
  var _contMessage = TextEditingController();
  var snapShot;
  var sender = '';
  var receiver = '';
  var senderReceiver = '';
  var receiverSender = '';
  var _scrollController = ScrollController();
  var lottieHeight = 0.0;
  var lottieWidth = 0.0;
  var imageHeight = 0.0;
  var imageWidth = 0.0;
  File file;
  var imageSource = ImageSource.gallery;
  var imageLink = '';
  var imageName = 'first';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lottieHeight = MediaQuery.of(context).size.height * 0.45;
    lottieWidth = MediaQuery.of(context).size.width * 0.45;
    imageHeight = MediaQuery.of(context).size.height * 0.16;
    imageWidth = MediaQuery.of(context).size.width * 0.50;
  }

  @override
  void initState() {
    Firebase.initializeApp();
    database = FirebaseDatabase.instance;
    firebaseStore = FirebaseStorage.instance;
    myRefSender = database.reference().child('messages');
    myRefReceiver = database.reference().child('messages');
    setState(() {
      sender = widget.senderUser;
      receiver = widget.receiver;
      senderReceiver = widget.senderReceiver;
      receiverSender = widget.senderReceiver.split('-').reversed.join('-');
    });
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
        centerTitle: false,
        title: Text(receiver),
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
                  stream: myRefSender.child(widget.senderReceiver).onValue,
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
                          imageName = key;
                          return Align(
                            alignment: notes[key]['sender'] == sender ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 1, 10, 0),
                              child: CustomPaint(
                                  painter: CustomChatBubble(isSender: notes[key]['sender'] == sender ? true : false),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                    decoration: BoxDecoration(
                                      color: notes[key]['sender'] == sender ? Colors.blue : Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                  child: notes[key]['type'] == 'text'
                                    ? Text(
                                        notes[key]['message'],
                                        style: TextStyle(color: notes[key]['sender'] == sender ? Colors.white : Colors.black)
                                      )
                                    : Image.network(notes[key]['message'],width: imageWidth)
                                )
                              )
                            )
                          );
                        }
                      );                    
                    }else
                      return Container(child: Center(child: Lottie.asset('assets/animationLottie/emptyScreen.json',height: lottieHeight,width: lottieWidth)));
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
                        maxLines: null,
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
                    onTap: () async {
                      imageSource = await sendImage();
                      uploadImageFile(imageSource);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400]
                      ),
                      child: Icon(Icons.image,color: Colors.white)
                    )
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  InkWell(
                    onTap: () => {
                      sendMessage('text'),
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

  sendImage() async{
    imageSource = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Choose image from'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,ImageSource.camera),
              child: Text("Camera",style: TextStyle(color: Colors.red))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,ImageSource.gallery),
              child: Text("Gallery")
            )
          ]
        );
      }
    );
    return imageSource;
  }

  Future<void> uploadImageFile(ImageSource imgSource) async{
    var photo = await ImagePicker().getImage(source: imgSource);
    if(photo!=null){
      file = File(photo.path);
      firebaseStore = FirebaseStorage.instance.ref().child("messages/images/$imageName"); 
      UploadTask uploadTask = firebaseStore.putFile(file);
      if(uploadTask!=null){
        var snapshot = await uploadTask.whenComplete(() => {
          print('Successfully uploaded')
        });
        var urlDownload = await snapshot.ref.getDownloadURL();
        print(urlDownload);
        _contMessage.text = urlDownload;
        sendMessage('image');
      }else
        print('Upload Task is null : ');
    }
  }

  sendMessage(String type){
    if(_contMessage.text.isNotEmpty){
      myRefSender.child(senderReceiver).push().set({
        'message' : _contMessage.text.toString(),
        'type' : type,
        'sender': sender,
      });
      myRefReceiver.child(receiverSender).push().set({
        'message' : _contMessage.text.toString(),
        'type': type,
        'sender': sender,
      });
    }
    _contMessage.clear();
  }
}
