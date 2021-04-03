import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool isFilled = false;
  bool isPasswordVisible = false;

  void checkLoginField(String email, String password) {
    if (email != '' && password != '')
      isFilled = true;
    else
      isFilled = false;
    notifyListeners();
  }

  void passwordVisible() {
    isPasswordVisible = isPasswordVisible ? false : true;
    notifyListeners();
  }
}
