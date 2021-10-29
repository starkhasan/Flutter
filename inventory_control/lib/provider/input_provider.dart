import 'package:flutter/cupertino.dart';

class InputProvider extends ChangeNotifier {
  bool _showFab = true;
  bool get showFabButton => _showFab;

  void fabVisibility(bool visible) {
    _showFab = visible;
    notifyListeners();
  }
}
