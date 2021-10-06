import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityProvider {
  StreamController<ConnectivityResult> connectivityController = StreamController<ConnectivityResult>();
  Stream<ConnectivityResult> get connectionStream => connectivityController.stream;

  Future<ConnectivityResult> getConnection() async{
    return await Connectivity().checkConnectivity();
  }

  ConnectivityProvider(){
    Connectivity().onConnectivityChanged.listen((event) {
      connectivityController.add(event);
    });
  }
}
