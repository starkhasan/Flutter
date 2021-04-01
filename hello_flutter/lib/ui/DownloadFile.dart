import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/Helper.dart';

class DownloadFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadFile();
}

class _DownloadFile extends State<StatefulWidget> {
  final String url = 'https://gfgc.kar.nic.in/sirmv-science/GenericDocHandler/138-a2973dc6-c024-4d81-be6d-5c3344f232ce.pdf';
  final String fileName = 'The Complete Reference of Java';
  bool isDownloading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Download File'),
      ),
      body: Container(
        child: Center(
          child: CupertinoButton(
            disabledColor: Colors.blue[50],
            onPressed: () async {
              if(isDownloading){
                setState(() {isDownloading = false;});
                var value = await Helper.downloadFile(url,fileName);
                Helper.showToast(value, Colors.black);
                setState(() {isDownloading = true;});
              }else{
                Helper.showToast('File Downloading....', Colors.black);
              }
            },
            child: Text('Storage Permission'),
            color: isDownloading ? Colors.blue : Colors.blue[100],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: isDownloading ? Colors.pink : Colors.pink[100],
          icon: isDownloading
              ? Icon(Icons.download_sharp)
              : SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    backgroundColor: Colors.white,
                  )),
          label: Text('Download'),
          onPressed: () async{
            if(isDownloading){
              setState(() {isDownloading = false;});
              var value = await Helper.downloadFile(url,fileName);
              Helper.showToast(value, Colors.black);
              setState(() {isDownloading = true;});
            }else{
              Helper.showToast('File Downloading....', Colors.black);
            }
          }
        ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: Duration(seconds: 2)));
  }
}
