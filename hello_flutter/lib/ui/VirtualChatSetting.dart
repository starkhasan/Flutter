import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/VirtualMedia.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class VirtualChatSetting extends StatefulWidget {
  final String sender;
  final bool update;
  VirtualChatSetting({@required this.sender,@required this.update});
  @override
  _VirtualChatSettingState createState() => _VirtualChatSettingState();
}

class _VirtualChatSettingState extends State<VirtualChatSetting> {
  var firebaseStorage;
  var firebaseDatabase;
  var file;
  var lottieHeight = 0.0;
  var lottieWidth = 0.0;
  var _topMargin = 0.0;
  var _contAbout = TextEditingController();
  var aboutMessage = '';

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    firebaseDatabase = FirebaseDatabase.instance.reference().child('users').child(widget.sender);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lottieHeight = MediaQuery.of(context).size.height * 0.45;
    lottieWidth = MediaQuery.of(context).size.width * 0.45;
    _topMargin = MediaQuery.of(context).size.height * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.update ? 'Settings' : widget.sender[0].toUpperCase()+widget.sender.substring(1)),
        backgroundColor: Colors.blue
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10,_topMargin,10,10),
        child: StreamBuilder(
          stream: firebaseDatabase.onValue,
          builder: (context,snapshot){
            if(!snapshot.hasData || snapshot.hasError){
              return Container(child: Center(child:  CircularProgressIndicator(color: Colors.blue,strokeWidth: 3))); 
            }else if(snapshot.hasData && snapshot.data.snapshot.value != null){
              var notes = snapshot.data.snapshot.value;
              aboutMessage = notes['about'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async{
                        if(notes['profile'] == ' ' && widget.update){
                          var source = await chooseImageSource();
                          uploadImageFile(source);
                        }else if(notes['profile'] != ' ')
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VirtualMedia(path: notes['profile'], name: widget.update ? 'Profile' : widget.sender[0].toUpperCase()+widget.sender.substring(1))));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        backgroundImage: notes['profile'] == ' ' ? null : NetworkImage(notes['profile']),
                        radius: 40,
                        child: notes['profile'] != ' ' ? null : Icon(Icons.add_a_photo,size: 30,color: Colors.white),
                      )
                    )
                  ),
                  SizedBox(height: _topMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_rounded),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About',style: TextStyle(color: Colors.grey)),
                              Text(notes['about'])
                            ]
                          )
                        ]
                      ),
                      Visibility(
                        visible: widget.update,
                        child: IconButton(
                          onPressed: () => aboutInfoDialog(aboutMessage),
                          icon: Icon(Icons.edit)
                        )
                      )
                    ]
                  )
                ]
              );                 
            }else
              return Container(child: Center(child: Lottie.asset('assets/animationLottie/emptyScreen.json',height: lottieHeight,width: lottieWidth)));
          }
        )
      )
    );
  }

  Future<ImageSource> chooseImageSource() async{
    var source = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Choose Image Source'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,ImageSource.camera),
              child: Text('Camera')
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: Text('Gallery',style: TextStyle(color: Colors.red))
            )
          ]
        );
      }
    );
    return source;
  }

  aboutInfoDialog(String info){
    _contAbout.text = info;
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          child: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About'),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: TextField(
                          controller: _contAbout,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLength: 100,
                          cursorColor: Colors.black,
                          cursorWidth: 1.5,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type a message',
                            hintStyle: TextStyle(color: Colors.grey[400])
                          )
                        )
                      )
                    ]
                  )
                ),
                Divider(height: 1,color: Colors.grey[400]),
                GestureDetector(
                  onTap: () => {
                    firebaseDatabase.update({
                      'about': _contAbout.text.isEmpty ? 'Hey there! I am VirtualChat' : _contAbout.text
                    }),
                    Navigator.pop(context)
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Center(child: Text('Submit',style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold)))
                  )
                )
              ]
            )
          )
        );
      }
    );
  }

  Future<void> uploadImageFile(ImageSource imgSource) async{
    var photo = await ImagePicker().getImage(source: imgSource);
    if(photo!=null){
      file = File(photo.path);
      firebaseStorage = FirebaseStorage.instance.ref().child("messages/users/${widget.sender}"); 
      UploadTask uploadTask = firebaseStorage.putFile(file);
      if(uploadTask!=null){
        var snapshot = await uploadTask.whenComplete(() => {
          print('Successfully uploaded')
        });
        var _imageURL = await snapshot.ref.getDownloadURL();
        firebaseDatabase.update({
          'profile': _imageURL
        }).then((value){
          showSnackBar('Profile Uploaded Successfully');
        }).catchError((value){
          showSnackBar('Something went wrong');
        });
      }else
        print('Upload Task is null : ');
    }
  }

  showSnackBar(String message){
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}