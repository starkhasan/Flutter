import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_chat/ui/ChatMedia.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ChatSetting extends StatefulWidget {
  final String sender;
  final bool update;
  const ChatSetting({ Key? key ,required this.sender,required this.update}) : super(key: key);

  @override
  _ChatSettingState createState() => _ChatSettingState();
}

class _ChatSettingState extends State<ChatSetting> with WidgetsBindingObserver{
  var firebaseStorage;
  var firebaseDatabase;
  var file;
  var lottieHeight = 0.0;
  var lottieWidth = 0.0;
  var _topMargin = 0.0;
  var _imageSize = 0.0;
  var _contAbout = TextEditingController();
  var _contOldPassword = TextEditingController();
  var _contNewPassword = TextEditingController();
  var aboutMessage = '';
  var userPassword = '';
  var currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    firebaseDatabase = FirebaseDatabase.instance.reference().child('users').child(widget.sender);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lottieHeight = MediaQuery.of(context).size.height * 0.45;
    lottieWidth = MediaQuery.of(context).size.width * 0.45;
    _topMargin = MediaQuery.of(context).size.height * 0.05;
    _imageSize = MediaQuery.of(context).size.height * 0.07;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.update ? 'Profile Update' : widget.sender[0].toUpperCase()+widget.sender.substring(1)),
        backgroundColor: Colors.indigo,
        brightness: Brightness.dark
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10,_topMargin,10,10),
        child: StreamBuilder(
          stream: firebaseDatabase.onValue,
          builder: (context,AsyncSnapshot snapshot){
            if(!snapshot.hasData || snapshot.hasError){
              return Container(child: Center(child:  CircularProgressIndicator(color: Colors.indigo,strokeWidth: 3))); 
            }else if(snapshot.hasData && snapshot.data.snapshot.value != null){
              var notes = snapshot.data.snapshot.value;
              aboutMessage = notes['about'];
              userPassword = notes['password'];
              if(notes['dob'].isNotEmpty){
                var dateAr = notes['dob'].split('-');
                currentDateTime = DateTime(int.parse(dateAr[0]),int.parse(dateAr[1]),int.parse(dateAr[2]));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: _imageSize * 2,
                      width: _imageSize * 2,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              notes['profile'] != ' '
                                ? Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMedia(path: notes['profile'], name: widget.update ? 'Profile' : widget.sender[0].toUpperCase()+widget.sender.substring(1),dateTime:'')))
                                : showSnackBar('Image Not Found');
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: notes['profile'] == ' ' ? NetworkImage('https://i.ibb.co/Tm8jmFY/add-1.png') : NetworkImage(notes['profile']),
                              radius: _imageSize
                            )
                          ),
                          Positioned(
                            right: 0,bottom: 0,
                            child: Visibility(
                              visible: widget.update,
                              child: Container(
                                width: _topMargin,
                                height: _topMargin,
                                decoration: BoxDecoration(color: Colors.indigo,shape: BoxShape.circle),
                                child: Center(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async{
                                      var source = await chooseImageSource();
                                      uploadImageFile(source);
                                    },
                                    icon: Icon(Icons.camera_alt_rounded,color: Colors.white)
                                  )
                                )
                              )
                            )
                          )
                        ]
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
                  ),
                  Visibility(
                    visible: widget.update,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.password_rounded),
                            SizedBox(width: 20),
                            Text('Change Password')
                          ]
                        ),
                        IconButton(
                          onPressed: () => changePasswordDialog(),
                          icon: Icon(Icons.edit)
                        )
                      ]
                    )
                  ),
                  Visibility(
                    visible: widget.update,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cake_rounded),
                            SizedBox(width: 20),
                            Text(
                              notes['dob'].isEmpty ? 'Birthday' : notes['dob'].split('-').reversed.join('-')
                            )
                          ]
                        ),
                        IconButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              maxTime: DateTime.now(),
                              onConfirm: (date) {
                                firebaseDatabase.update({
                                  'dob': date.toString().substring(0,10)
                                });
                              },
                              currentTime: currentDateTime, locale: LocaleType.en
                            );
                          },
                          icon: Icon(Icons.edit)
                        )
                      ]
                    )
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

  changePasswordDialog(){
    _contOldPassword.text = '';
    _contNewPassword.text = '';
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
                    children: [
                      TextField(
                        controller: _contOldPassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.newline,
                        maxLength: 6,
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        style: TextStyle(color: Colors.black,fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          counter: Offstage()
                        )
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _contNewPassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.newline,
                        maxLength: 6,
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        style: TextStyle(color: Colors.black,fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          counter: Offstage()
                        )
                      )
                    ]
                  )
                ),
                Divider(color: Colors.grey,height: 1),
                Container(
                  color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            color: Colors.white,
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Center(child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.red)))
                            )
                        )
                      ),
                      VerticalDivider(color: Colors.grey[350],width: 1),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if(passwordValidation()){
                              showSnackBar('Password Successfully Updated');
                              firebaseDatabase.update({'password': _contNewPassword.text});
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15 ),
                            child: Center(child: Text('Submit',style: TextStyle(fontSize: 16,color: Colors.indigo)))
                          )
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
    );
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
                Divider(height: 0.0,color: Colors.grey[400],thickness: 0.8,),
                GestureDetector(
                  onTap: () => {
                    firebaseDatabase.update({
                      'about': _contAbout.text.isEmpty ? 'Hey there! I am using VirtualChat' : _contAbout.text
                    }),
                    Navigator.pop(context)
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Center(child: Text('Submit',style: TextStyle(fontSize: 18,color: Colors.indigo)))
                  )
                )
              ]
            )
          )
        );
      }
    );
  }

  bool passwordValidation(){
    if(_contOldPassword.text.isEmpty){
      showSnackBar('Please provide Old Password');
      return false;
    }else if(_contOldPassword.text.length < 6){
      showSnackBar('Minimum length should be 6');
      return false;
    }else if(_contNewPassword.text.isEmpty){
      showSnackBar('Please provide New Password');
      return false;
    }else if(_contNewPassword.text.length < 6){
      showSnackBar('Minimum length should be 6');
      return false;
    }else if(userPassword != _contOldPassword.text){
      showSnackBar('Wrong Old Password');
      return false;
    }
    return true;
  }

  Future<void> uploadImageFile(ImageSource imgSource) async{
    var photo = await ImagePicker().getImage(source: imgSource);
    if(photo!=null){
      file = File(photo.path);
      firebaseStorage = FirebaseStorage.instance.ref().child("messages/users/${widget.sender}"); 
      UploadTask uploadTask = firebaseStorage.putFile(file);
      if(uploadTask != null){
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