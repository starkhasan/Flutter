import 'package:flutter/cupertino.dart';

class NotesProvider extends ChangeNotifier {
  bool fabVisible = true;
  bool taskContainerVisible = false;

  void fabAction() {
    fabVisible = fabVisible ? false : true;
    taskContainerVisible = taskContainerVisible ? false : true;
    notifyListeners();
  }
}
