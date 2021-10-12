import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:notes_todo/utils/preferences.dart';

class NotesProvider extends ChangeNotifier {
  bool fabVisible = true;
  bool taskContainerVisible = false;
  Map<String, dynamic> listNote = jsonDecode(Preferences.getStoredTask());
  List<String> completedList = Preferences.getCompleteTask();

  void fabAction() {
    fabVisible = fabVisible ? false : true;
    taskContainerVisible = taskContainerVisible ? false : true;
    notifyListeners();
  }

  void deleteAllNotes() {
    listNote.clear();
    completedList.clear();
    convertMaptoString();
    storeCompleTaskLocally();
    notifyListeners();
  }

  void addTask(String task) {
    listNote[task] = false;
    convertMaptoString();
    notifyListeners();
  }

  void removeTask(String item) {
    listNote.removeWhere((key, value) => key == item);
    convertMaptoString();
    notifyListeners();
  }

  void checkedTask(String item) {
    listNote[item] = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 250), () {
      listNote.removeWhere((key, value) => key == item);
      completedList.add(item);
      storeCompleTaskLocally();
      convertMaptoString();
      notifyListeners();
    });
  }

  void removeCompletedTask(String item) {
    completedList.removeWhere((element) => element == item);
    storeCompleTaskLocally();
    notifyListeners();
  }

  void checkedCompletedTask(int index) {
    var item = completedList[index];
    listNote[item] = false;
    completedList.remove(item);
    convertMaptoString();
    storeCompleTaskLocally();
    notifyListeners();
  }

  void convertMaptoString() {
    var jsonString = jsonEncode(listNote);
    Preferences.storeTask(jsonString);
  }

  void storeCompleTaskLocally() {
    Preferences.storeCompleteTask(completedList);
  }
}
