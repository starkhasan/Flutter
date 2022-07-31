import 'package:flutter_stream/model/album_response.dart';
import 'package:flutter_stream/resources/api_provider.dart';
import 'package:flutter_stream/model/todo_response.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<List<AlbumResponse>> fetchAlbum() => apiProvider.getAlbum();
  Future<List<TodoResponse>> fetchTodo() => apiProvider.getTodo();
}
