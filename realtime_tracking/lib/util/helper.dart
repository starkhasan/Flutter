import 'package:flutter/material.dart';

class Helper{

  showSnackBar(BuildContext _context,String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
}