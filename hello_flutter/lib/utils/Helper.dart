import 'package:flutter/material.dart';

class Helper {
  Helper._();

  static List<Text> getCountryList() {
    List<Text> listText = [
      Text('India'),
      Text('Australia'),
      Text('England'),
      Text('South Africa'),
      Text('New Zealand'),
      Text('West Indies'),
      Text('Pakistan'),
      Text('Bangladesh'),
      Text('Afganistan'),
      Text('Zimbabwae'),
      Text('Kenya'),
      Text('Canada'),
      Text('UAE'),
      Text('United State of America'),
      Text('Indonesia'),
      Text('Africa'),
      Text('California'),
      Text('Nepal')
    ];
    return listText;
  }

  /*static Future<bool> isConnected() async {
    var connectivityResult =  await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return  true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return  true;
    }
    return false;
  }*/
}
