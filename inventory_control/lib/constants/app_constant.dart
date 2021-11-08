import 'package:flutter/material.dart';

class AppConstant {
  static List<String> homeTitle = ['Input', 'Output', 'Inventory'];

  static List<Icon> icons = const [
    Icon(Icons.download,color: Colors.blue),
    Icon(Icons.upload,color: Colors.red),
    Icon(Icons.inventory,color: Colors.green)
  ];

  static List<Icon> homeIcon = const [Icon(Icons.inventory),Icon(Icons.settings)];
  static List<String> screenName = ['Add Inventory','Settings'];
}