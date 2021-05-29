import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageExample extends StatefulWidget {
  @override
  _FirebaseStorageExampleState createState() => _FirebaseStorageExampleState();
}

class _FirebaseStorageExampleState extends State<FirebaseStorageExample> {

  var firebaseStorage;
  File fileName;
  var imageSource = ImageSource.gallery;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    firebaseStorage = FirebaseStorage.instance.ref().child("messages/images/"); 
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Firebase Storage')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          imageSource  = await uploadImage();
          readImageFile(imageSource);
        },
        child: Icon(Icons.camera),
      ),
      body: Container(
        child: Center(
          child: Text('Firebase Storage')
        )
      )
    );
  }

  uploadImage() async{
    imageSource = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Select image'),
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

  Future<void> readImageFile(ImageSource imgSource) async{
    var file = await ImagePicker().getImage(source: imgSource);
    if(file != null){
      fileName = File(file.path);
      firebaseStorage = FirebaseStorage.instance.ref().child("messages/images/taj2"); 
      UploadTask uploadTask = firebaseStorage.putFile(fileName);
      if(uploadTask!=null){
        var snapshot = await uploadTask.whenComplete(() => {
          showSnackBar()
        });
        final urlDownload = await snapshot.ref.getDownloadURL();
        print('Download-Link: $urlDownload');
      }else
        print('Upload Task is null : ');
    }else
      print('Please Select Image');
  }

  showSnackBar(){
    var snackBar = SnackBar(content: Text('File Successfully Uploaded'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}