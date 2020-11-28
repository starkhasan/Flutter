import 'package:connectivity/connectivity.dart';

class Helper {
  Helper._();
  static Future<bool> isConnected() async {
    var connectivityResult =  await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return  true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return  true;
    }
    return false;
  }
}
