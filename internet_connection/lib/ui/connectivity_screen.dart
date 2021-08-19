import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection/provider/connectivity_provider.dart';
import 'package:provider/provider.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>(
      initialData: ConnectivityResult.none,
      create: (_) => ConnectivityProvider().connectionStream,
      child: Consumer<ConnectivityResult>(
        builder: (context,provider,child){
          checkConnectivity(provider,context);
          return const Scaffold(
            body: Center(
              child: Text('Internet Connectivity')
            )
          );
        }
      )
    );
  }

  void checkConnectivity(ConnectivityResult result,BuildContext context){
    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
      Timer(const Duration(seconds: 2), () => Navigator.pop(context));
    }else{
      var snackBar = const SnackBar(content: Text('Try Again!',style: TextStyle(color: Colors.red)),duration: Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}