import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorage extends StatefulWidget {
  @override
  _FirebaseStorageState createState() => _FirebaseStorageState();
}

class _FirebaseStorageState extends State<FirebaseStorage> {

  var firebaseStorage;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    firebaseStorage = FirebaseStorage();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Firebase Storage')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => uploadImage(),
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

  }
}