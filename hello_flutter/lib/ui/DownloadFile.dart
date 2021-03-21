import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:permission_handler/permission_handler.dart';


class DownloadFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadFile();
}

class _DownloadFile extends State<StatefulWidget> {
  final String url = 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  final String fileName = 'test';
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Download File'),
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
