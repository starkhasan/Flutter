import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
mixin Helpers{

  showSnackBar(BuildContext _context,String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 3));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  bool validateEmail(String email){
    var regExp = RegExp(r'^(([a-zA-Z0-9_\.\-]*)@([a-zA-Z0-9]+)\.([a-zA-Z0-9]{2,5}))$');
    if(regExp.hasMatch(email)){
      return true;
    }
    return false;
  }
}