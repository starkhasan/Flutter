import 'package:flutter/cupertino.dart';
import 'package:notes_todo/utils/preferences.dart';

class NotesProvider extends ChangeNotifier {
  bool fabVisible = true;
  bool taskContainerVisible = false;
  int selectedTaskIndex = -1;
  List<String> listNote = Preferences.getStoredTask();
  List<String> completedList = Preferences.getCompleteTask();

  void fabAction() {
    fabVisible = fabVisible ? false : true;
    taskContainerVisible = taskContainerVisible ? false : true;
    notifyListeners();
  }

  void deleteAllNotes() {
    listNote.clear();
    completedList.clear();
    storeTaskLocally();
    storeCompleteTaskLocally();
    notifyListeners();
  }

  void addTask(String task) {
    listNote.add(task);
    storeTaskLocally();
    notifyListeners();
  }

  void removeTask(String item) {
    listNote.removeWhere((key) => key == item);
    storeTaskLocally();
    notifyListeners();
  }

  void checkedTask(String item, int index) {
    selectedTaskIndex = index;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 250), () {
      listNote.removeWhere((key) => key == item);
      completedList.add(item);
      storeCompleteTaskLocally();
      storeTaskLocally();
      selectedTaskIndex = -1;
      notifyListeners();
    });
  }

  void removeCompletedTask(String item) {
    completedList.removeWhere((element) => element == item);
    storeCompleteTaskLocally();
    notifyListeners();
  }

  void unCheckedCompletedTask(int index) {
    var item = completedList[index];
    listNote.add(item);
    completedList.remove(item);
    storeTaskLocally();
    storeCompleteTaskLocally();
    notifyListeners();
  }

  void undoCompleteTask(String item, int position) {
    completedList.insert(position, item);
    storeCompleteTaskLocally();
    notifyListeners();
  }

  void undoTask(String item, int position) {
    listNote.insert(position, item);
    storeTaskLocally();
    notifyListeners();
  }

  void storeTaskLocally() {
    Preferences.storeTask(listNote);
  }

  void storeCompleteTaskLocally() {
    Preferences.storeCompleteTask(completedList);
  }
}
