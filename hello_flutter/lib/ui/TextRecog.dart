import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextRecog extends StatefulWidget {
  @override
  _TextRecogState createState() => _TextRecogState();
}

class _TextRecogState extends State<TextRecog> {
  // var _imagePath = '';
  // final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  // final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
  // var _visionImage;
  // var _visionText;
  // var _imageText = '';
  // RegExp regExp =  RegExp(r"^[0-9]+(\.[0-9]{1,2})?$");
  // var _amount = 0.0;
  // var _imageSource = ImageSource.gallery;
  // List<Rect> rect = [];
  // var isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Text Recongnition'),
      ),
      body: Container(child: Text('sdfsdf')),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: isProcessing
      //     ? Colors.grey
      //     : null,
      //   onPressed: isProcessing
      //    ? null
      //    : () async{
      //     _imageSource = await _chooseSource()??ImageSource.gallery;
      //     //_textRecongnition(_imageSource);
      //     _detectFace(_imageSource);
      //   },
      //   child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
      // ),
      // body: Container(
      //   padding: EdgeInsets.all(15),
      //   child: Column(
      //     children: [
      //       Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: MediaQuery.of(context).size.height * 0.50,
      //         color: Colors.grey[100],
      //         child: _imagePath != ''
      //         ? Image.file(
      //             File(_imagePath),
      //             width: MediaQuery.of(context).size.width,
      //             height: MediaQuery.of(context).size.height * 0.50
      //           )
      //         : Center(
      //           child: Text(
      //             'Please Select Images',
      //             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
      //           )
      //         )
      //       ),
      //       Container(
      //         margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      //         child: isProcessing
      //           ? CircularProgressIndicator()
      //           : Text(
      //           _imageText,
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold
      //           )
      //         )
      //       )
      //     ]
      //   )
      // )
    );
  }

  Future<ImageSource> _chooseSource() async{
    var imageSource = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Please choose the source of Image'),
          actions: [
            CupertinoDialogAction(
              child: Text('Camera'),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            CupertinoDialogAction(
              child: Text('Gallery',style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            )
          ],
        );
      }
    );
    return imageSource;
  }

  // Future<void> _textRecongnition(ImageSource _source) async{
  //   var image = await ImagePicker().getImage(source: _source);
  //   if (image != null) {
  //     _amount = 0.0;
  //     _imageText = '';
  //     _imagePath = image.path;
  //     _visionImage = FirebaseVisionImage.fromFilePath(image.path);
  //     _visionText = await textRecognizer.processImage(_visionImage);
  //     for (TextBlock block in _visionText.blocks) {
  //       for (TextLine line in block.lines) {
  //         if(regExp.hasMatch(line.text)){
  //           if(_amount < double.parse(line.text)){
  //             _amount = double.parse(line.text);
  //           }
  //         }
  //       }
  //     }
  //     _imageText = 'Total Amount paid    =    ' + _amount.toStringAsFixed(2);
  //   }else{
  //     _imageText = "Couldn't get the image, Please try again!";
  //   }
  //   setState(() {});
  // }


  // Future<void> _detectFace(ImageSource _source) async{
  //   var image = await ImagePicker().getImage(source: _source);
  //   if (image != null) {
  //     setState(() {isProcessing = true;});
  //     _imageText = '';
  //     _imagePath = image.path;
  //     _visionImage = FirebaseVisionImage.fromFilePath(image.path);
  //     List<Face> _listFace = await faceDetector.processImage(_visionImage);
  //     _imageText = 'Total People in Frame    =    ' + _listFace.length.toString();
  //     // for (Face face in _listFace) {
  //     //   rect.add(face.boundingBox);
  //     // }
  //     isProcessing = false;
  //   }else{
  //     _imageText = "Couldn't get the image, Please try again!";
  //   }
  //   setState(() {});
  // }
}


