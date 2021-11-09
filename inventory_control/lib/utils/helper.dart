import 'package:flutter/material.dart';
import 'package:inventory_control/utils/inventory_create_dialog.dart';
import 'package:inventory_control/view/input_page.dart';
import 'package:inventory_control/view/inventory_page.dart';
import 'package:inventory_control/view/output_page.dart';
import 'package:inventory_control/provider/home_provider.dart';
import 'package:inventory_control/view/setting_page.dart';

mixin Helper{
  
  showSnackBar(BuildContext _context,String message){
    var snackBar = SnackBar(content: Text(message,style: const TextStyle(fontSize: 11)),duration: const Duration(seconds: 3));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  bool validateEmail(String email){
    var regExp = RegExp(r'^(([a-zA-Z0-9_\.\-]*)@([a-zA-Z0-9]+)\.([a-zA-Z0-9]{2,5}))$');
    if(regExp.hasMatch(email)){
      return true;
    }
    return false;
  }

  homePageNavigation(BuildContext _context,int index){
    switch (index) {
      case 0:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const InputPage()));
        break;
      case 1:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const OutputPage()));
        break;
      case 2:
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const InventoryPage()));
        break;
      default:
    }
  }

  drawerClick(BuildContext _context,int index,HomeProvider provider){
    switch (index) {
      case 0:
        Navigator.pop(_context);
        showDialog(
          barrierDismissible: false,
          context: _context, 
          builder: (context){
            return CreateInventoryDialog(provider: provider);
          }
        );
        break;
      case 1:
        Navigator.pop(_context);
        Navigator.push(_context, MaterialPageRoute(builder: (context) => const SettingPage()));
        break;
      default:
    }
  }
}