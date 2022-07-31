import 'package:flutter_stream/model/album_response.dart';
import 'package:flutter_stream/model/todo_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider{

  Future<List<AlbumResponse>> getAlbum() async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    var data = List<AlbumResponse>.from(jsonDecode(response.body).map((item) => AlbumResponse.fromJson(item)));
    return data;
  }

  Future<List<TodoResponse>> getTodo() async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    var data = List<TodoResponse>.from(jsonDecode(response.body).map((item) => TodoResponse.fromJson(item)));
    return data;
  }
}