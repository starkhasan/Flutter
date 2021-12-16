import 'package:flutter/cupertino.dart';
import 'package:notes_todo/utils/helpers.dart';
import 'package:notes_todo/utils/preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class NotesProvider extends ChangeNotifier with Helpers {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('notes_todo');
  bool fabVisible = true;
  String _name = '';
  bool taskContainerVisible = false;
  int selectedTaskIndex = -1;
  bool _dataSync = false;
  String get getUserName => _name;
  bool get isDataSync => _dataSync;
  List<String> listNote = Preferences.getStoredTask();
  List<String> completedList = Preferences.getCompleteTask();

  void fabAction() {
    fabVisible = fabVisible ? false : true;
    taskContainerVisible = taskContainerVisible ? false : true;
    notifyListeners();
  }

  void deleteAllNotes() {
    Preferences.setLocalDelete(true);
    if (Preferences.getSyncEnabled()) {
      Preferences.setSyncEnabled(false);
      listNote.clear();
      completedList.clear();
      storeTaskLocally();
      storeCompleteTaskLocally();
      Preferences.setSyncEnabled(true);
    } else {
      listNote.clear();
      completedList.clear();
      storeTaskLocally();
      storeCompleteTaskLocally();
    }
    notifyListeners();
  }

  void addTask(String task) {
    listNote.add(task);
    storeTaskLocally();
    notifyListeners();
  }

  void removeTask(String item, int index) {
    listNote.removeAt(index);
    storeTaskLocally();
    notifyListeners();
  }

  void checkedTask(int index) {
    selectedTaskIndex = index;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 250), () {
      completedList.add(listNote[index]);
      listNote.removeAt(index);
      storeCompleteTaskLocally();
      storeTaskLocally();
      selectedTaskIndex = -1;
      notifyListeners();
    });
  }

  void removeCompletedTask(int index) {
    completedList.removeAt(index);
    storeCompleteTaskLocally();
    notifyListeners();
  }

  void unCheckedCompletedTask(int index) {
    listNote.add(completedList[index]);
    completedList.removeAt(index);
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

  void storeTaskLocally() async {
    if (Preferences.getSyncEnabled()) {
      if (listNote.isNotEmpty) {
        if (Preferences.getLocalDeleted()) {
          _dataSync = true;
          notifyListeners();
          await databaseReference.child(Preferences.getUserID()).once().then((DatabaseEvent event) {
            if (event.snapshot.value != null) {
              var _data = event.snapshot.value as Map;
              if (_data['task'] != null) {
                var tempTask = _data['task'].split(',');
                for (var item in tempTask) {
                  listNote.add(item);
                }
              }
              if (_data['completeTask'] != null) {
                var tempTask = _data['completeTask'].split(',');
                for (var item in tempTask) {
                  completedList.add(item);
                }
              }
            }
          });
          Preferences.setLocalDelete(false);
          _dataSync = false;
          notifyListeners();
        }
        await databaseReference.child(Preferences.getUserID()).update({'task': listNote.join(',')});
      } else {
        await databaseReference.child(Preferences.getUserID()).child('task').remove();
      }
    }
    Preferences.storeTask(listNote);
  }

  void storeCompleteTaskLocally() async {
    if (Preferences.getSyncEnabled()) {
      if (completedList.isEmpty) {
        await databaseReference.child(Preferences.getUserID()).child('completeTask').remove();
      } else {
        await databaseReference.child(Preferences.getUserID()).update({'completeTask': completedList.join(',')});
      }
    }
    Preferences.storeCompleteTask(completedList);
  }

  void drawerName() {
    listNote = Preferences.getStoredTask();
    completedList = Preferences.getCompleteTask();
    _name = Preferences.getUserName();
    notifyListeners();
  }

  void syncEnableFromSyncNote(BuildContext _context) async {
    if (await checkInternetConnection()) {
      _dataSync = true;
      notifyListeners();
      await databaseReference.child('').once().then((value) => {});
      await databaseReference.child(Preferences.getUserID()).once().then((DatabaseEvent event) {
        if (event.snapshot.value != null) {
          var data = event.snapshot.value as Map;
          if (data['name'] != null) {
            _name = data['name'];
            Preferences.setUserName(data['name']);
          }

          if (data['task'] != null) {
            listNote = Preferences.getStoredTask();
            var tempTask = data['task'].split(',');
            for (var item in tempTask) {
              if (!listNote.contains(item)) listNote.add(item);
            }
            databaseReference.child(Preferences.getUserID()).update({'task': listNote.join(',')});
            Preferences.storeTask(listNote);
          }

          if (data['completeTask'] != null) {
            completedList = Preferences.getCompleteTask();
            var tempTask = data['completeTask'].split(',');
            for (var item in tempTask) {
              if (!completedList.contains(item)) completedList.add(item);
            }
            databaseReference.child(Preferences.getUserID()).update({'completeTask': completedList.join(',')});
            Preferences.storeCompleteTask(completedList);
          }
          Preferences.setLocalDelete(false);
        }
      });
      _dataSync = false;
      notifyListeners();
    } else {
      showSnackBar(_context, 'No Internet Connection');
    }
  }
}
