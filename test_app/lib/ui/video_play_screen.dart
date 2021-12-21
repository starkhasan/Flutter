import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/ui/full_screen_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen>{

  List<String> listVideos = [];
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
    readInternalFiles(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Videos')),
      body: ListView.builder(
        itemCount: listVideos.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          var videoData = listVideos[index].split('+');
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
  Future<void> readInternalFiles(BuildContext context) async{
    listVideos.clear();
    try {
      var result = await platformMethodChannel.invokeMethod('readExternalFile');
      result.forEach((item) {
        //File Size greater than 256MB unable to play by the video_player package
        var _tempFile = item.split('+');
        if (double.parse(_tempFile[2]) < 240324271) {
          listVideos.add(item);
        }
      });
    } catch (e) {
      listVideos = [];
    }
    setState(() {});
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
            child: VideoPlayer(videoPlayerController)
          );
        }
        else {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2.0));
        }
      }
    );
  }
}
