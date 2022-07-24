import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final StreamController<ConnectivityResult> _connectivityController = StreamController<ConnectivityResult>();
  Stream<ConnectivityResult> get connectionStream => _connectivityController.stream;


  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((event) {
      _connectivityController.add(event);
    });
  }
}
