import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadFile();
}

class _DownloadFile extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Download File'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Please Download File on Click FAB'),
        child: Icon(Icons.download_sharp),
      ),
    );
  }
}
