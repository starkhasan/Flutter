import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{
  StreamController<ConnectivityResult> connectivtyController = StreamController<ConnectivityResult>();
  Stream<ConnectivityResult> get connectionStream => connectivtyController.stream;

  ConnectivityService(){
    Connectivity().onConnectivityChanged.listen((event) { 
      connectivtyController.add(event);
    });
  }

  Future<bool> getConnection() async{
    var connection = await Connectivity().checkConnectivity();
    if(connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi){
      return true;
    }
    return false;
  }
}