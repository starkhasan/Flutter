import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class TextRecog extends StatefulWidget {
  @override
  _TextRecogState createState() => _TextRecogState();
}

class _TextRecogState extends State<TextRecog> {
  var _imagePath = '';
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  var _visionImage;
  var _visionText;
  var _imageText = '';
  RegExp regExp =  RegExp(r"^[0-9]+(\.[0-9]{1,2})?$");
  var _amount = 0.0;
  var _imageSource = ImageSource.gallery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Text Recongnition'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _imageSource = await _chooseSource()??ImageSource.gallery;
          _processImage(_imageSource);
        },
        child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.50,
              color: Colors.grey[100],
              child: _imagePath != ''
              ? Image.file(
                  File(_imagePath),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.50
                )
              : Center(
                child: Text(
                  'Please Select Images',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                )
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                _imageText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              )
            )
          ]
        )
      )
    );
  }

  Future<ImageSource> _chooseSource() async{
    var imageSource = await showDialog(
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Please choose the source of Image'),
          actions: [
            CupertinoDialogAction(
              child: Text('Camera'),
              onPressed: () => Navigator.pop(context,ImageSource.camera),
            ),
            CupertinoDialogAction(
              child: Text('Gallery',style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.pop(context,ImageSource.gallery),
            )
          ],
        );
      }
    );

    return imageSource;
  }

  Future<void> _processImage(ImageSource _source) async{
    var image = await ImagePicker().getImage(source: _source);
    if (image != null) {
      _amount = 0.0;
      _imageText = '';
      _imagePath = image.path;
      _visionImage = FirebaseVisionImage.fromFilePath(image.path);
      _visionText = await textRecognizer.processImage(_visionImage);
      for (TextBlock block in _visionText.blocks) {
        for (TextLine line in block.lines) {
          if(regExp.hasMatch(line.text)){
            if(_amount == 0.0){
              _amount = double.parse(line.text);
            }else if(_amount < double.parse(line.text)){
              _amount = double.parse(line.text);
            }
          }
        }
      }
      _imageText = 'Total Amount paid    =    ' + _amount.toStringAsFixed(2);
    }else{
      _imageText = "Couldn't get the image, Please try again!";
    }
    setState(() {});
  }
}
