import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectivityResult> _connectionController =
      StreamController<ConnectivityResult>();
  Stream<ConnectivityResult> get connectionStream =>
      _connectionController.stream;
  Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)
      return true;
    else
      return false;
  }

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((event) {
      _connectionController.add(event);
    });
  }
}
