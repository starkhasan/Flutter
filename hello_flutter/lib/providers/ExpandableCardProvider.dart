import 'package:flutter/cupertino.dart';

class ExpandableCardProvider extends ChangeNotifier {
  int selected = 0;

  void expandCard(int index) {
    selected = index;
    notifyListeners();
  }
  
}
