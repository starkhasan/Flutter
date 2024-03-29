import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:virtual_chat/ui/ChatMedia.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

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
    _topMargin = MediaQuery.of(context).size.height * 0.04;
    _imageSize = MediaQuery.of(context).size.height * 0.06;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.update ? 'Profile Update' : widget.sender[0].toUpperCase()+widget.sender.substring(1),style: TextStyle(fontSize: 14)),
        backgroundColor: Colors.indigo,
        systemOverlayStyle: SystemUiOverlayStyle.light
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
                            onTap: ()  async {
                              var imagePath = await getImagePath(widget.sender, notes['profile']);
                              notes['profile'] != ' '
                                ? Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMedia(path: imagePath, name: widget.update ? 'Profile' : widget.sender[0].toUpperCase()+widget.sender.substring(1),dateTime:'')))
                                : showSnackBar('Image Not Found');
                            },
                            child: FutureBuilder(
                              future: getImagePath(widget.sender, notes['profile']),
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
                                  return  CircleAvatar(
                                    radius: _imageSize,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: FileImage(File(snapshot.data))
                                  );
                                }else{
                                  return Padding(padding: EdgeInsets.all(4),child: CircularProgressIndicator(strokeWidth: 2.0));
                                }
                              }
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
                                    icon: Icon(Icons.camera_alt_rounded,color: Colors.white,size: 20)
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
                          Icon(Icons.info_rounded,size: 20),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About',style: TextStyle(color: Colors.grey,fontSize: 12)),
                              Text(notes['about'],style: TextStyle(fontSize: 12))
                            ]
                          )
                        ]
                      ),
                      Visibility(
                        visible: widget.update,
                        child: IconButton(
                          onPressed: () => aboutInfoDialog(aboutMessage),
                          icon: Icon(Icons.edit,size: 20)
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
                            Icon(Icons.password_rounded,size: 20),
                            SizedBox(width: 15),
                            Text('Change Password',style: TextStyle(fontSize: 12))
                          ]
                        ),
                        IconButton(
                          onPressed: () => changePasswordDialog(),
                          icon: Icon(Icons.edit,size: 20)
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
                            Icon(Icons.cake_rounded,size: 20),
                            SizedBox(width: 15),
                            Text(
                              notes['dob'].isEmpty ? 'Birthday' : notes['dob'].split('-').reversed.join('-'),
                              style: TextStyle(fontSize: 12)
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
                          icon: Icon(Icons.edit,size: 20)
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

  Future<String> getImagePath(String name,String url) async{
    url = url.isEmpty ? 'https://i.ibb.co/Tm8jmFY/add-1.png' : url;
    //var imageName = notes[key]['time'].substring(0,10).replaceAll('-','')
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/IMG-${name.replaceAll(RegExp(r"[\\-\s+\\,:.]"),'')}.jpg');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<ImageSource> chooseImageSource() async{
    var source = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Choose Image Source',style: TextStyle(fontSize: 14)),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,ImageSource.camera),
              child: Text('Camera',style: TextStyle(fontSize: 14))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: Text('Gallery',style: TextStyle(color: Colors.red,fontSize: 14))
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
                  margin: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: _contOldPassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.newline,
                        maxLength: 6,
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        style: TextStyle(color: Colors.black,fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          hintStyle: TextStyle(color: Colors.grey[400],fontSize: 12),
                          counter: Offstage()
                        )
                      ),
                      TextField(
                        controller: _contNewPassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.newline,
                        maxLength: 6,
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        style: TextStyle(color: Colors.black,fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: TextStyle(color: Colors.grey[400],fontSize: 12),
                          counter: Offstage()
                        )
                      )
                    ]
                  )
                ),
                Divider(color: Colors.grey[350],height: 0.5),
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
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                              child: Center(child: Text('Cancel',style: TextStyle(fontSize: 14,color: Colors.red)))
                            )
                        )
                      ),
                      VerticalDivider(color: Colors.grey[350],width: 0.5),
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
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: Center(child: Text('Submit',style: TextStyle(fontSize: 14,color: Colors.indigo)))
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
                      Text('About',style: TextStyle(fontSize: 12)),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextField(
                          controller: _contAbout,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLength: 100,
                          cursorColor: Colors.black,
                          cursorWidth: 1.5,
                          style: TextStyle(color: Colors.black,fontSize: 12),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type a message',
                            hintStyle: TextStyle(color: Colors.grey[400],fontSize: 12)
                          )
                        )
                      )
                    ]
                  )
                ),
                Divider(height: 0.0,color: Colors.grey[400],thickness: 0.5),
                GestureDetector(
                  onTap: () => {
                    firebaseDatabase.update({
                      'about': _contAbout.text.isEmpty ? 'Hey there! I am using VirtualChat' : _contAbout.text
                    }),
                    Navigator.pop(context)
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Center(child: Text('Submit',style: TextStyle(fontSize: 14,color: Colors.indigo)))
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