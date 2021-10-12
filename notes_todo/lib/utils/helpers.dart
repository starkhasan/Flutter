import 'package:flutter/material.dart';

mixin Helpers{

  showSnackBar(BuildContext context,String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}