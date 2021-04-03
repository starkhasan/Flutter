import 'package:flutter/foundation.dart';

class SignupProvider extends ChangeNotifier{
  bool isPasswordVisible = false;
  bool isFilled = false;

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