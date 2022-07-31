import 'dart:async';
import 'package:navigation_route/model/todo_response.dart';
import 'package:navigation_route/network/api.dart';

class HomeController {
  //Stream Controller for adding TodoResponse
  StreamController<List<TodoResponse>> streamController = StreamController<List<TodoResponse>>();
  //Sink to add the data
  Sink<List<TodoResponse>> get sink => streamController.sink;

  ///Stream to return the data to the view
  Stream<List<TodoResponse>> get todoStream => streamController.stream;

  ///Response Data
  List<TodoResponse> todoResponse = [];

  Future<void> getTodo() async {
    var data = await Api.fetchTodo();
    todoResponse.addAll(data);
    sink.add(todoResponse);
  }

  void dispose() {
    streamController.close();
  }

  //to complete the task of todo notes
  void completeTask(int index,bool? value){
    todoResponse[index].completed = value!;
    sink.add(todoResponse);
  }
}

final homeController = HomeController();
