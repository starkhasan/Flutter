import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'dart:io';

class WidgetDemo extends StatefulWidget {
  @override
  _WidgetDemoState createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  List<dynamic> _listSongs = [];
  int songIndex = -1;
  bool isPlaying = false;

  @override
  void initState() {
    _askPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Widget Demo'),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _listSongs.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // if (audioPlayer.state != null) {
                //   if (audioPlayer.state.index == 2)
                //     audioPlayer.play(_listSongs[index].path, isLocal: true);
                //   else {
                //     if (songIndex == index) {
                //       isPlaying = isPlaying ? false : true;
                //       audioPlayer.pause();
                //     } else {
                //       audioPlayer.play(_listSongs[index].path, isLocal: true);
                //       isPlaying = true;
                //     }
                //   }
                //   setState(() {
                //     songIndex = index;
                //   });
                // } else {
                //   audioPlayer.play(_listSongs[index].path, isLocal: true);
                //   setState(() {
                //     isPlaying = true;
                //     songIndex = index;
                //   });
                // }
              },
              child: Card(
                color: songIndex == index ? Colors.pink[200] : Colors.white,
                child: ListTile(
                    title: Text(_listSongs[index].path.split('/').last),
                    trailing: songIndex != index
                        ? null
                        : isPlaying
                            ? Icon(Icons.pause_outlined)
                            : Icon(Icons.play_arrow)),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => _askPermission(),
      //   icon: Icon(Icons.share),
      //   label: Text('WhatsApp'),
      //   backgroundColor: Colors.green[600],
      // ),
    );
  }

  Future<void> _askPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      _openFile();
    } else {
      var availPermission = await _requestPermission();
      availPermission
          ? _openFile()
          : Helper.showToast('Please grant permission', Colors.red);
    }
  }

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted) return true;
    return false;
  }

  Future<void> _openFile() async {
    var dir = Directory('/storage/emulated/0/');
    String mp3Path = dir.toString();
    print(mp3Path);
    List<FileSystemEntity> _files;
    List<FileSystemEntity> _songs = [];
    _files = dir.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in _files) {
      String path = entity.path;
      if (path.endsWith('.mp3')) _songs.add(entity);
    }
    _listSongs.clear();
    setState(() {
      _listSongs.addAll(_songs);
    });
    print(_songs.length);
  }
}
