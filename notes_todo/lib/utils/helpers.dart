import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
mixin Helpers{

  showSnackBar(BuildContext _context,String message){
    var snackBar = SnackBar(content: Text(message,style: const TextStyle(fontSize: 11)),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  bool validateEmail(String email){
    var regExp = RegExp(r'^(([a-zA-Z0-9_\.\-]*)@([a-zA-Z0-9]+)\.([a-zA-Z0-9]{2,5}))$');
    if(regExp.hasMatch(email)){
      return true;
    }
    return false;
  }

  Future<bool> checkInternetConnection() async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return true;
    }
    return false;
  }
}