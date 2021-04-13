import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/network/response/YouTubeVideosResponse.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:hello_flutter/constants/keys.dart';
import 'dart:convert';

class YouTubeFlutter extends StatefulWidget {
  @override
  _YouTubeFlutterState createState() => _YouTubeFlutterState();
}

class _YouTubeFlutterState extends State<YouTubeFlutter> {

  String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=UkEA5cSYgdE");
  YoutubePlayerController _controller; 
  var dio = Dio();
  YouTubeVideosResponse youTubeVideosResponse = YouTubeVideosResponse();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        enableCaption: true,
        forceHD: true
      )
    );
  }

  _getYouTubeVideos() async{
    String query = 'iron man';
    var url = 'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&q=$query&type=video&key=${Keys.YOUTUBE_API_KEY}';
    Response response = await dio.get(url);
    setState(() {
      youTubeVideosResponse = YouTubeVideosResponse.fromJson(json.decode(response.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('You Tube'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () => _getYouTubeVideos(), 
            icon: Icon(Icons.video_collection)
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red  
            ),
            Expanded(
              child: youTubeVideosResponse.items != null
                ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: youTubeVideosResponse.items.length,
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5)]
                      ),
                      child: Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(youTubeVideosResponse.items[index].snippet.thumbnails.medium.url,width: 150),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      youTubeVideosResponse.items[index].snippet.title,
                                      softWrap: true,
                                      maxLines: 5,
                                    )
                                  ),
                                  SizedBox(height: 10),
                                  Flexible(
                                    child: Text(
                                      youTubeVideosResponse.items[index].snippet.channelTitle,
                                      softWrap: true,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  )
                                ],
                              )
                            )
                          ],
                        )
                      ),
                    );
                  }
                )
                : Center(child: Text('No Vides Found'))
            )
          ],
        )
      ),
    );
  }
}