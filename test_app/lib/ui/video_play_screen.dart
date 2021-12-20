import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/ui/full_screen_player.dart';
import 'package:test_app/utils/helper.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen>{
  late VideoPlayerController videoPlayerController;

  static const platformMethodChannel = MethodChannel('com.example.test_app/battery_level');

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset('asset/video/bee.mp4')
      ..initialize().then((value) => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Videos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          readInternalFiles(context);
        },
        child: const Icon(Icons.file_download)
      ),
      body: FutureBuilder(
        future: getAllVideos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load Assets'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => FullScreenPlayer(videoAssetName: snapshot.data[index]))),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: videoPlayerController.value.isInitialized
                        ? VideoPlayer(videoPlayerController)
                        : const Center(child: CircularProgressIndicator(strokeWidth: 2.0))
                      ),
                      title: Text(snapshot.data[index].substring(12, snapshot.data[index].length - 4))
                    )
                  )
                );
              }
            );
          }
        }
      )
    );
  }

  Future<dynamic> getAllVideos() async {
    var listVideoAssets = [];
    var manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    var images = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('asset/video'));
    images.forEach((element) => listVideoAssets.add(element));
    return listVideoAssets;
  }

  Future<void> readInternalFiles(BuildContext context) async{
      String batteryLevel = '';
      try {
        var result = await platformMethodChannel.invokeMethod('readExternalFile');
        print(result);
      } catch (e) {
        batteryLevel = 'Failed to read the file';
      }
  }



}
