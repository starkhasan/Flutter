import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:covid_info/service/ConnectivityService.dart';
import 'package:covid_info/ui/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>(
      initialData: ConnectivityResult.none,
      create: (_) => ConnectivityService().connectionStream,
      builder: (context, child) {
        return MainScreen();
      }
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var provider;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(0xff0B3054),statusBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ConnectivityResult>(context);
    startTimer(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.jpg',height: MediaQuery.of(context).size.height * 0.12, width: MediaQuery.of(context).size.height * 0.12),
                  Text(
                    'Covid Info',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: '')
                  )
                ]
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Design & Developed by : Traversal',
                      style: TextStyle(color: Colors.grey[200],fontSize: 11)
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  startTimer(BuildContext _context) {
    Timer(Duration(seconds: 3), (){
        if(provider != null){
        if(provider == ConnectivityResult.wifi || provider == ConnectivityResult.mobile){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
        }else{
          var snackBar = SnackBar(
            elevation: 0.0,
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content: Text('No Internet Connection',style: TextStyle(color: Colors.white)),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          );
          ScaffoldMessenger.of(_context).showSnackBar(snackBar);
        }
      }
    });
  }
}