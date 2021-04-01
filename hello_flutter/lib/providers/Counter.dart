import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int count = 0;
  void increment() {
    ++count;
    notifyListeners();
  }
}
