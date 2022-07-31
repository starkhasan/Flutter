import 'dart:async';
import 'package:flutter_stream/model/album_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleStream {
  int count = 0;
  StreamController<AlbumResponse> streamController = StreamController<AlbumResponse>();
  Stream<AlbumResponse> get counterStream => streamController.stream;
  late StreamSubscription<AlbumResponse> streamSubscription;

  SingleStream() {
    streamSubscription = streamCounterMethod().listen((event) {
      streamController.add(event);
    });
    streamSubscription.cancel();
    streamCounterMethod().listen((event) {
      streamController.add(event);
    });
  }

  Stream<AlbumResponse> streamCounterMethod() async* {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    var listAlbum = List<AlbumResponse>.from(jsonDecode(response.body).map((item) => AlbumResponse.fromJson(item)));
    for(var item in listAlbum){
      await Future.delayed(const Duration(seconds: 1));
      yield item;
    }
  }
}
