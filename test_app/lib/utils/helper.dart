import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  Helper {
  
  static void show_snack_bar(BuildContext context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}