import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_control/services/connectivity_service.dart';
import 'package:inventory_control/utils/preferences.dart';
import 'package:inventory_control/view/authentication_page.dart';
import 'dart:async';

import 'package:inventory_control/view/home_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferences.init();
    return StreamProvider<ConnectivityResult>(
      create: (_) => ConnectivityService().connectionStream,
      initialData: ConnectivityResult.none,
      builder: (context,child){
        return const MainSplashScreen();
      }
    );
  }
}


class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({ Key? key }) : super(key: key);

  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {

  late ConnectivityResult provider;
  double imageSize = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    imageSize = MediaQuery.of(context).size.height * 0.12;
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
                  Image.asset('asset/app_icon.png',height: imageSize, width: imageSize),
                  const Text(
                    'Inventory',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                  )
                ]
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Design & Developed by : Traversal',
                      style: TextStyle(color: Colors.grey[100],fontSize: 10)
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
    Timer(const Duration(seconds: 3), (){
      if(provider != null){
        if(provider == ConnectivityResult.wifi || provider == ConnectivityResult.mobile){
          if(Preferences.getLogin()){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationPage()));
          }
        }else{
          var snackBar = const SnackBar(
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