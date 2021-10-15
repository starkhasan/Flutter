import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
mixin Helpers{

  showSnackBar(BuildContext _context,String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 3));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
}