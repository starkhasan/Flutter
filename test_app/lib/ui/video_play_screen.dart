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
    videoPlayerController = VideoPlayerController.contentUri(Uri.parse('content://media/external/video/media/261'))
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
      body: FutureBuilder(
        future: readInternalFiles(context),
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
                var videoData = snapshot.data[index].split('+');
                return InkWell(
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => FullScreenPlayer(videoContentUri: videoData[1]))),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: ThumbNailWidget(contentUri: videoData[1])
                      ),
                      title: Text(videoData[0])
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

  //Get All Videos of the Assets
  Future<dynamic> getAllVideos() async {
    var listVideoAssets = [];
    var manifestJson = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    var images = json.decode(manifestJson).keys.where((String key) => key.startsWith('asset/video'));
    images.forEach((element) => listVideoAssets.add(element));
    return listVideoAssets;
  }

  //Get All Videos File From Android Internal Storage Using the Platform Channel
  Future<dynamic> readInternalFiles(BuildContext context) async{
    var listVideos = [];
    try {
      var result = await platformMethodChannel.invokeMethod('readExternalFile');
      result.forEach((item) => listVideos.add(item));
    } catch (e) {
      listVideos = [];
    }
    return listVideos;
  }
}

class ThumbNailWidget extends StatefulWidget {
  final String contentUri;
  const ThumbNailWidget({ Key? key, required this.contentUri}) : super(key: key);

  @override
  _ThumbNailWidgetState createState() => _ThumbNailWidgetState();
}

class _ThumbNailWidgetState extends State<ThumbNailWidget> {

  late VideoPlayerController videoPlayerController;
  late Future<void> initializedVideoPLayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.contentUri(Uri.parse(widget.contentUri));
    initializedVideoPLayerFuture = videoPlayerController.initialize().then((value) => setState((){}));
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializedVideoPLayerFuture,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            key: PageStorageKey(widget.contentUri),
            child: VideoPlayer(videoPlayerController), 
          );
        }
        else {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2.0));
        }
      }
    );
  }
}
