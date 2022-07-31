import 'package:flutter/material.dart';
import 'package:flutter_stream/model/todo_response.dart';
import 'package:flutter_stream/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  //instance of the repository to get the data
  final reposoitory = Repository();
  //StreamController
  final behaviorController = BehaviorSubject<List<TodoResponse>>();
  //Stream
  Stream<List<TodoResponse>> get allTodoResponse => behaviorController.stream;

  fetchTodo() async {
    var data = await reposoitory.fetchTodo();
    behaviorController.add(data);
  }

  Future<bool> addTodo(BuildContext context, String title, bool taskCompleted) async {
    if (validation(context, title)) {
      var lastData = behaviorController.value;
      var newData = TodoResponse(userId: lastData[lastData.length - 1].userId + 1, id: lastData[lastData.length - 1].userId + 1, title: title, completed: taskCompleted);
      lastData.insert(0, newData);
      behaviorController.add(lastData);
      showSnackBar(context, 'Todo added successfully');
      return true;
    }
    return false;
  }

  //method to delete the todo using behaviorSubject.value to get the last value emitted to stream by controller
  deleteTodo(BuildContext context, int index) {
    var lastData = behaviorController.value;
    lastData.removeAt(index);
    behaviorController.add(lastData);
    showSnackBar(context, 'Todo Deleted Successfully');
  }

  //method to close the behaviourSubject(StreamController)
  dispose() {
    behaviorController.close();
  }

  bool validation(BuildContext context, String title) {
    if (title.isEmpty) {
      showSnackBar(context, 'Please provide title');
      return false;
    }
    return true;
  }

  void showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message), duration: const Duration(milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
