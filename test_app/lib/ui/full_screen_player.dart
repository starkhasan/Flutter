import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoContentUri;
  const FullScreenPlayer({ Key? key,required this.videoContentUri}) : super(key: key);

  @override
  _FullScreenPlayerState createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {

  late VideoPlayerController videoPlayerController;
  double maxValue = 0.0;
  double minValue = 0.0;
  double trackValue = 0.0;
  bool controllerVisible = true;
  String startTime = '--:--';
  String endTime = '--:--';


  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.contentUri(Uri.parse(widget.videoContentUri))
    ..initialize().then((value) => {
      timerToHideController(),
      videoPlayerController.addListener(() {
        setState(() {
          maxValue = videoPlayerController.value.duration.inSeconds.toDouble();
          minValue = 0.0;
          trackValue = videoPlayerController.value.position.inSeconds.toDouble();
          startTime = "${videoPlayerController.value.position.inHours}:${videoPlayerController.value.position.inMinutes.remainder(60)}:${(videoPlayerController.value.position.inSeconds.remainder(60))}";
          endTime = "${videoPlayerController.value.duration.inHours}:${videoPlayerController.value.duration.inMinutes.remainder(60)}:${(videoPlayerController.value.duration.inSeconds.remainder(60))}";
        });
        
      })
    });
    videoPlayerController.play();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
    super.dispose();
  }

  timerToHideController(){
    Timer(const Duration(seconds: 5),() => {
      setState((){
        controllerVisible = controllerVisible ? false : true; 
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return WillPopScope(
      onWillPop: ()  async {
        if(videoPlayerController.value.isInitialized) await videoPlayerController.dispose();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () => {
                  setState(() => controllerVisible = true),
                  timerToHideController()
                },
                child: VideoPlayer(videoPlayerController)
              )
            ),
            Visibility(
              visible: controllerVisible,
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => videoPlayerController.seekTo(const Duration(seconds: -10)),
                            child: const Icon(
                              Icons.replay_10_sharp,
                              size: 40,
                              color: Colors.white
                            )
                          ),
                          const SizedBox(width: 30),
                          InkWell(
                            onTap: () => {
                              setState(() {
                                videoPlayerController.value.isPlaying
                                ? videoPlayerController.pause()
                                : videoPlayerController.play();
                              })
                            },
                            child: Icon(
                              videoPlayerController.value.isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                              size: 60,
                              color: Colors.white
                            )
                          ),
                          const SizedBox(width: 30),
                          InkWell(
                            onTap: () => videoPlayerController.seekTo(const Duration(seconds: 10)),
                            child: const Icon(
                              Icons.forward_10_sharp,
                              size: 40,
                              color: Colors.white
                            )
                          )
                        ]
                      )
                    ),
                    Positioned(
                      top: 30,
                      left: 20,
                      child: IconButton(
                        onPressed: () => {
                          if(videoPlayerController.value.isInitialized) videoPlayerController.dispose(),
                          Navigator.pop(context),
                        },
                        icon: const Icon(Icons.arrow_back,color: Colors.white)
                      )
                    ),
                    Positioned(
                      bottom: 5,
                      child: Container(
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                startTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                )
                              )
                            ),
                            Expanded(
                              child: Slider(
                                activeColor: Colors.red,
                                inactiveColor: Colors.white54,
                                value: trackValue, 
                                max: maxValue, 
                                min: minValue,
                                onChanged: (value) => {
                                  videoPlayerController.seekTo(Duration(seconds: value.toInt()))
                                }
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                endTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                )
                              )
                            )
                          ]
                        )
                      )
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}
