import 'package:flutter/material.dart';
import 'package:flutter_desktop/constants/strings.dart';
import '../networks/api/api_client.dart';
import '../utils/progress_dialog.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  late ProgressDialog _dialog;
  late ApiClient _apiClient;
  String errorEmail = Strings.emptyValue;
  String errorPassword = Strings.emptyValue;
  bool showPassword = false;

  @override
  void onInit() {
    _apiClient = ApiClient();
    _dialog = ProgressDialog(Get.context!);
    super.onInit();
  }

  void passwordVisibility() {
    showPassword = showPassword ? false : true;
    update();
  }

  void onEmailTextChange(){
    if(errorEmail.isNotEmpty){
      errorEmail = Strings.emptyValue;
      update();
    }
  }

  void onPasswordTextChange(){
    if(errorPassword.isNotEmpty){
      errorPassword = Strings.emptyValue;
      update();
    }
  }

  Future<void> loginUser() async {
    if(validation()){
      _dialog.show();
      await Future.delayed(const Duration(seconds: 5));
      _dialog.hide();
    }
  }

  bool validation() {
    if(emailTextController.text.isEmpty){
      errorEmail = 'Enter an Email';
      if(passwordTextController.text.isEmpty) errorPassword = 'Enter a password';
      update();
      return false;
    }else if(!emailTextController.text.isEmail){
      errorEmail = 'Enter a valid email';
      if(passwordTextController.text.isEmpty) errorPassword = 'Enter a password';
      update();
      return false;
    } else if(passwordTextController.text.isEmpty){
      errorPassword = 'Enter a password';
      if(emailTextController.text.isEmpty) errorEmail = 'Enter an Email';
      update();
      return false;
    } else if(passwordTextController.text.length < 8){
      errorPassword = 'Weak password, Length must be atleast 8 character';
      if(emailTextController.text.isEmpty) errorEmail = 'Enter an Email';
      update();
      return false;
    }
    return true;
  }
}