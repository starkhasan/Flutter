import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoFile extends StatefulWidget {
  @override
  _PhotoFileState createState() => _PhotoFileState();
}

class _PhotoFileState extends State<PhotoFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text('Photo File')),
          body: Container(
            child: Center(
              child: RaisedButton(
                onPressed: () => _getPhotos(),
                child: Text('Get Photo'),
              ),
            ),
          ),
        );
  }

  _getPhotos() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> list = await PhotoManager.getAssetPathList();
      print(list.length);
    } else {
      Fluttertoast.showToast(
          msg: 'Please Grant Permission',
          textColor: Colors.white,
          backgroundColor: Colors.red);
    }
  }
}
