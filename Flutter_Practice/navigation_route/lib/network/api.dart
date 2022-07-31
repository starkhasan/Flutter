import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:navigation_route/model/todo_response.dart';

class Api{
  
  static Future<List<TodoResponse>> fetchTodo() async {
    try {
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if(response.statusCode == 200){
        return List<TodoResponse>.from(jsonDecode(response.body).map((item) => TodoResponse.fromJson(item)));
      }else{
        return [];
      }
    } catch (e) {
      return [];
    }
  }

}