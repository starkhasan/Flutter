import 'package:flutter/material.dart';

mixin Helper{

  void showSnackBar(String message, BuildContext context){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}