import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/LoginUser.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/ui/NotificationScreen.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class Spalsh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _spalshState();
}

class _spalshState extends State<Spalsh> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var isLogin = false;
  @override
  void initState() {
    super.initState();
    Preferences.getLogin().then((value) {
      setState(() {
        isLogin = value;
      });
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotificationScreen()));
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NotificationScreen()));
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 2), () {
      if(isLogin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUser()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Text(
            'Splash Screen',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
