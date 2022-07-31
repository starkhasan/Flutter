import 'package:flutter_stream/model/album_response.dart';
import 'package:flutter_stream/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AlbumBloc {
  final reposoitory = Repository();
  //StreamCOntroller
  final publishController = PublishSubject<List<AlbumResponse>>();
  //Stream
  Stream<List<AlbumResponse>> get allAlbum => publishController.stream;

  fetchAlbum() async {
    var data = await reposoitory.fetchAlbum();
    publishController.add(data);
  }

  //method to close the Controller Listening
  dispose() {
    publishController.close();
  }
}

final bloc = AlbumBloc();
