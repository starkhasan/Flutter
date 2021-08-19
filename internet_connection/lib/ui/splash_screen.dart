import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection/provider/connectivity_provider.dart';
import 'package:internet_connection/ui/connectivity_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Splash Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => checkConnection(context),
        child: const Icon(Icons.network_cell),
      ),
      body: const Center(
        child: Text('Splash Screen')
      )
    );
  }

  checkConnection(BuildContext context) async{
    var result = await ConnectivityProvider().getConnection();
    if(result == ConnectivityResult.none){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectivityScreen()));
    }else{
      var snackbar = const SnackBar(content: Text('Connected',style: TextStyle(color: Colors.green)),duration: Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}