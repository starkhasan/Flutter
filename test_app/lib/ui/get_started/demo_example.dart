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
            child: VideoPlayer(VideoPlayerController.asset(listVideos[index])..initialize()),
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