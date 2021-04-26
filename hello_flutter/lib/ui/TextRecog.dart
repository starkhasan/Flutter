import 'dart:io';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Text Recongnition'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var image = await ImagePicker().getImage(source: ImageSource.gallery);
          if(image!=null){
            _imagePath = image.path;
            _visionImage = FirebaseVisionImage.fromFilePath(image.path);
            _visionText = await textRecognizer.processImage(_visionImage);
            for (TextBlock block in _visionText.blocks) {
              for (TextLine line in block.lines) {
                _imageText += line.text + '\n';
              }
            }
            setState((){});
          }
        },
        child: Icon(Icons.camera_alt,size: 30,color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.file(File(_imagePath),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height * 0.50),
            Text(_imageText)
          ]
        )
      )
    );
  }
}
