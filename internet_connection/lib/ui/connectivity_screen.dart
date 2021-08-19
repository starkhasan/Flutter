import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection/provider/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

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
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: kToolbarHeight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  )
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lotties/connectivity.json',height: MediaQuery.of(context).size.width * 0.30,width: MediaQuery.of(context).size.width * 0.30),
                      const Text('No Internet Connection',style: TextStyle(color: Colors.black,fontSize: 18)),
                      const SizedBox(height: 5),
                      const Flexible(child: Text('Please check your internet connection and try again')),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => checkConnectivity(provider, context),
                        child: const Text('Retry')
                      )
                    ]
                  )
                )
              ]
            )
          );
        }
      )
    );
  }

  void checkConnectivity(ConnectivityResult result,BuildContext context){
    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
      Timer(const Duration(seconds: 2), () => Navigator.pop(context));
    }
  }
}