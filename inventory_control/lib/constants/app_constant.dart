import 'package:flutter/material.dart';

class AppConstant {
  static List<String> homeTitle = ['Input', 'Output', 'Inventory'];

  static List<Icon> icons = const [
    Icon(Icons.download,color: Colors.blue),
    Icon(Icons.upload,color: Colors.red),
    Icon(Icons.inventory,color: Colors.green)
  ];

  static List<Icon> homeIcon = const [
    Icon(Icons.inventory,size: 22),
    Icon(Icons.settings,size: 22)
  ];
  
  static List<String> screenName = ['Add Inventory','Settings'];
}