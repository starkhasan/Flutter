import 'package:flutter/material.dart';
import 'dart:math' as math;

class RandomNumberProvider extends ChangeNotifier {
  int number = 0;
  
  void getNumber() {
    number = math.Random().nextInt(100);
    notifyListeners();
  }
}
