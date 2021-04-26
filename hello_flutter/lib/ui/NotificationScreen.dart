import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Languages.of(context).notification),
      ),
      body: Container(
        child: Center(
          child: Text("Notification"),
        ),
      ),
    );
  }
}
