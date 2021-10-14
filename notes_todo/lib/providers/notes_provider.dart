import 'package:flutter/cupertino.dart';
import 'package:notes_todo/utils/preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class NotesProvider extends ChangeNotifier {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('notes');
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
    Preferences.setSyncEnabled(false);
    listNote.clear();
    completedList.clear();
    storeTaskLocally();
    storeCompleteTaskLocally();
    Preferences.setSyncEnabled(true);
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
    if (Preferences.getSyncEnabled()) {
      if (listNote.isNotEmpty) {
        databaseReference
            .child(Preferences.getUserID())
            .update({'task': listNote.join(',')});
      } else {
        databaseReference.child(Preferences.getUserID()).child('task').remove();
      }
    }
    Preferences.storeTask(listNote);
  }

  void storeCompleteTaskLocally() {
    if (Preferences.getSyncEnabled()) {
      if (completedList.isEmpty) {
        databaseReference
            .child(Preferences.getUserID())
            .child('completeTask')
            .remove();
      } else {
        databaseReference
            .child(Preferences.getUserID())
            .update({'completeTask': completedList.join(',')});
      }
    }
    Preferences.storeCompleteTask(completedList);
  }
}
