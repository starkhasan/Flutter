import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_chat/ui/ChatMedia.dart';
import 'package:virtual_chat/ui/ChatSetting.dart';

class ChattingScreen extends StatefulWidget {
  final String sender;
  final String receiver;
  final String senderImagePath;
  const ChattingScreen({ Key? key ,required this.sender,required this.receiver,required this.senderImagePath}) : super(key: key);
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> with WidgetsBindingObserver{

  var statusDatabase;
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
  var appBarImageSize = 0.0;
  late File file;
  var imageSource = ImageSource.gallery;
  var imageLink = '';
  var imageName = 'first';
  var chatTime = DateTime.now();
  var imageUploading = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lottieHeight = MediaQuery.of(context).size.height * 0.45;
    lottieWidth = MediaQuery.of(context).size.width * 0.45;
    imageHeight = MediaQuery.of(context).size.height * 0.045;
    imageWidth = MediaQuery.of(context).size.width * 0.50;
    appBarImageSize = MediaQuery.of(context).size.width * 0.04;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    database = FirebaseDatabase.instance;
    firebaseStore = FirebaseStorage.instance;
    myRefSender = database.reference().child('messages');
    myRefReceiver = database.reference().child('messages');
    statusDatabase = database.reference().child('users');
    setState(() {
      sender = widget.sender;
      receiver = widget.receiver;
      senderReceiver = widget.sender+'-'+widget.receiver;
      receiverSender = widget.receiver+'-'+widget.sender;
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
        backgroundColor: Colors.indigo,
        centerTitle: false,
        titleSpacing: 0.0,
        title: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatSetting(sender: receiver, update: false))),
          child: Container(
            padding: EdgeInsets.fromLTRB(0,5,5,5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: widget.senderImagePath == ' ' ? NetworkImage('https://i.ibb.co/Tm8jmFY/add-1.png') : NetworkImage(widget.senderImagePath),
                  radius: appBarImageSize
                ),
                SizedBox(width: 5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(receiver[0].toUpperCase()+receiver.substring(1)),
                    StreamBuilder(
                      stream: statusDatabase.child(receiver).onValue,
                      builder: (context,AsyncSnapshot snapshot){
                        if(snapshot.hasData && snapshot.data.snapshot.value != null){
                          var allUser = snapshot.data.snapshot.value;
                          return allUser['status'] == 'offline'
                            ? SizedBox()
                            : Text(allUser['status'],style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal));
                        }else{
                          return SizedBox();
                        }
                      }
                    )
                  ]
                )
              ]
            )
          )
        ),
        brightness: Brightness.dark
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                color: Colors.white,
                child: StreamBuilder(
                  stream: myRefSender.child(senderReceiver).onValue,
                  builder: (context,AsyncSnapshot snapshot){
                    if(!snapshot.hasData || snapshot.hasError){
                      return Container(child: Center(child:  CircularProgressIndicator(color: Colors.indigo,strokeWidth: 3))); 
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
                          return Container(
                            child: Align(
                              alignment: notes[key]['sender'] == sender ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                  decoration: BoxDecoration(
                                    color: notes[key]['sender'] == sender ? Colors.indigo : Colors.grey[300],
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: notes[key]['type'] == 'text'
                                  ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        notes[key]['message'],
                                        style: TextStyle(color: notes[key]['sender'] == sender ? Colors.white : Colors.black,fontSize: 16)
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        notes[key]['time'].substring(11,16),
                                        style: TextStyle(
                                          color: notes[key]['sender'] == sender ? Colors.white70 : Colors.black54,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal
                                        )
                                      )
                                    ]
                                  )
                                  : GestureDetector(
                                    onTap: ()  {
                                      var user = notes[key]['sender'] == widget.sender ? 'You' : notes[key]['sender'];
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMedia(path: notes[key]['message'], name: user,dateTime: notes[key]['time'])));
                                    },
                                    child: Hero(
                                      tag: 'Image Hero$index',
                                      child: Stack(
                                        fit: StackFit.passthrough,
                                        children: [
                                          Image.network(notes[key]['message'],width: imageWidth),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(color: Colors.black26,spreadRadius: 5.0,blurRadius: 5.0)
                                                ]
                                              ),
                                              padding: EdgeInsets.fromLTRB(10,10,5,5),
                                              child: Text(
                                                notes[key]['time'].substring(11,16),
                                                style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,decoration: TextDecoration.none)
                                              )
                                            )
                                          )
                                        ]
                                      )
                                    )
                                  )
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
              padding: EdgeInsets.fromLTRB(5, 4, 5, 5),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      child: TextField(
                        controller: _contMessage,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        style: TextStyle(color: Colors.black,fontSize: 16),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 16)
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo
                      ),
                      child: imageUploading
                        ? SizedBox(height: 25,width: 25,child:CircularProgressIndicator(backgroundColor: Colors.grey[100],strokeWidth: 2.0))
                        : Icon(Icons.image,color: Colors.white)
                    )
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  InkWell(
                    onTap: () => {
                      sendMessage('text'),
                      scrollToBottom()
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo
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
    setState(() { imageUploading = true;});
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
        setState(() { imageUploading = false;});
        _contMessage.text = urlDownload;
        sendMessage('image');
      }else
        print('Upload Task is null : ');
    }
  }

  sendMessage(String type){
    var time = DateTime.now();
    if(_contMessage.text.isNotEmpty){
      myRefSender.child(senderReceiver).push().set({
        'message' : _contMessage.text.toString(),
        'type' : type,
        'sender': sender,
        'time': time.toString()
      });
      myRefReceiver.child(receiverSender).push().set({
        'message' : _contMessage.text.toString(),
        'type': type,
        'sender': sender,
        'time': time.toString()
      });
    }
    _contMessage.clear();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      statusDatabase.child(sender).update({
          'status': 'online'
      });
    }else{
      statusDatabase.child(sender).update({
          'status': 'offline'
      });
    }
  }
}