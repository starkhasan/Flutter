import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:permission_handler/permission_handler.dart';

class WidgetDemo extends StatefulWidget {
  @override
  _WidgetDemoState createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  final String url = 'https://file-examples-com.github.io/uploads/2017/10/file-example_PDF_1MB.pdf';
  final String fileName = 'test';
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('This is center title'),
      ),
      body: Container(
        child: Center(child: Text('Download File From')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: isEnabled ? Colors.pink : Colors.pink[100],
        icon: isEnabled
          ? Icon(Icons.download_sharp)
          : SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              backgroundColor: Colors.white,
            )
          ),
        label: Text('Download'),
        onPressed: () => isEnabled
          ? _askStoragePermission()
          : showSnackBar('Fil downloading...')
      ),
    );
  }

  Future<void> downloadFile(url, fileName) async {
    String savePath = await getFilePath(fileName);
    var dio = new Dio();
    File(savePath).exists().then((value) {
      if (value){
        setState(() {
            isEnabled = true;
        });
        showSnackBar('File Already downloaded');
      }else{
         dio.download(url, savePath, onReceiveProgress: (rcv, total) {
          print('receive ${rcv.toStringAsFixed(0)} out of total ${total.toStringAsFixed(0)}');
        }).catchError((onError) {
          setState(() {
            isEnabled = true;
          });
          showSnackBar('File not found');
        }).then((value) {
          setState(() {
            isEnabled = true;
          });
          showSnackBar('File downloaded successfully');
        });
      }
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    path = '/storage/emulated/0/Download/$uniqueFileName.pdf';
    return path;
  }

  Future<void> _askStoragePermission() async {
    setState(() {
      isEnabled = false;
    });
    var status = await Permission.storage.status;
    if (status.isGranted) {
      downloadFile(url, fileName);
    } else {
      _getStoragePermission();
    }
  }

  Future<void> _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      downloadFile(url, fileName);
    } else {
      Helper.showToast('Please grant permission to download file', Colors.red);
      setState(() {
        isEnabled = true;
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: Duration(seconds: 2)));
  }
}
