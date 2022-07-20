import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/strings.dart';
import '../networks/api/api_client.dart';
import '../utils/progress_dialog.dart';

class SignupController extends GetxController {

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  late ProgressDialog _dialog;
  late ApiClient _apiClient;
  String errorName = Strings.emptyValue;
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

  void onNameTextChange(){
    if(errorName.isNotEmpty){
      errorName = Strings.emptyValue;
      update();
    }
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

  Future<void> signupUser() async {
    if(validation()){
      _dialog.show();
      await Future.delayed(const Duration(seconds: 5));
      _dialog.hide();
    }
  }

  bool validation() {
    if(nameTextController.text.isEmpty){
      errorName = 'Enter name';
      if(emailTextController.text.isEmpty) errorEmail = 'Enter an Email';
      if(passwordTextController.text.isEmpty) errorPassword = 'Enter a password';
      update();
      return false;
    }else if(emailTextController.text.isEmpty){
      errorEmail = 'Enter an Email';
      if(nameTextController.text.isEmpty) errorEmail = 'Enter name';
      if(passwordTextController.text.isEmpty) errorPassword = 'Enter a password';
      update();
      return false;
    }else if(!emailTextController.text.isEmail){
      errorEmail = 'Enter a valid email';
      if(nameTextController.text.isEmpty) errorEmail = 'Enter name';
      if(passwordTextController.text.isEmpty) errorPassword = 'Enter a password';
      update();
      return false;
    } else if(passwordTextController.text.isEmpty){
      errorPassword = 'Enter a password';
      if(nameTextController.text.isEmpty) errorEmail = 'Enter name';
      if(emailTextController.text.isEmpty) errorEmail = 'Enter an Email';
      update();
      return false;
    } else if(passwordTextController.text.length < 8){
      errorPassword = 'Weak password, Length must be atleast 8 character';
      if(nameTextController.text.isEmpty) errorEmail = 'Enter name';
      if(emailTextController.text.isEmpty) errorEmail = 'Enter an Email';
      update();
      return false;
    }
    return true;
  }
  
}