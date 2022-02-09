import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DemoExample extends StatefulWidget {
  const DemoExample({Key? key}) : super(key: key);

  @override
  DemoExampleState createState() => DemoExampleState();
}
class DemoExampleState extends State<DemoExample>{

  late VideoPlayerController videoPlayerController;
  late PageController pageController;
  List<String> listVideos = [];
  var videoIndex = 0;

  @override
  void initState() {
    getAllVideos();
    videoPlayerController = VideoPlayerController.asset('asset/video/bee.mp4')
      ..initialize().then((value) => setState((){}));
    pageController = PageController(initialPage: 0)
      ..addListener(pageViewListener);
    super.initState();
  }

  pageViewListener(){
    var data = pageController.page;
    if(data.toString().length == 3){
      if(videoIndex != data!.toInt()){
        videoIndex = data.toInt();
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: listVideos.length,
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ThumbNailWidget(assetName: listVideos[index])
          );
        }
      )
    );
  }

  //Get All Videos of the Assets
  Future<dynamic> getAllVideos() async {
    List<String> listVideoAssets = [];
    var manifestJson = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    var video = jsonDecode(manifestJson).keys.where((String key) => key.startsWith('asset/video'));
    video.forEach((element) => listVideoAssets.add(element));
    setState(() => listVideos.addAll(listVideoAssets));
  }
}

class ThumbNailWidget extends StatefulWidget {
  final String assetName;
  const ThumbNailWidget({ Key? key, required this.assetName}) : super(key: key);
  @override
  _ThumbNailWidgetState createState() => _ThumbNailWidgetState();
}

class _ThumbNailWidgetState extends State<ThumbNailWidget> {
  late VideoPlayerController videoPlayerController;
  late Future<void> initializedVideoPLayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(widget.assetName);
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
            key: PageStorageKey(widget.assetName),
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
