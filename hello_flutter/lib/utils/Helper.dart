import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

class Helper {
  Helper._();

  static List<Widget> getCountryList() {
    List<Widget> listText = [
      Center(child: Text('India')),
      Center(child: Text('Australia')),
      Center(child: Text('England')),
      Center(child: Text('South Africa')),
      Center(child: Text('New Zealand')),
      Center(child: Text('West Indies')),
      Center(child: Text('Pakistan')),
      Center(child: Text('Bangladesh')),
      Center(child: Text('Afganistan')),
      Center(child: Text('Zimbabwae')),
      Center(child: Text('Kenya')),
      Center(child: Text('Canada')),
      Center(child: Text('UAE')),
      Center(child: Text('United State of America')),
      Center(child: Text('Indonesia')),
      Center(child: Text('Africa')),
      Center(child: Text('California')),
      Center(child: Text('Nepal'))
    ];
    return listText;
  }

  static Map<int, String> getCountry() {
    var countryMap = Map<int, String>();
    countryMap[0] = 'India';
    countryMap[1] = 'Australia';
    countryMap[2] = 'England';
    countryMap[3] = 'South Africa';
    countryMap[4] = 'New Zealand';
    countryMap[5] = 'West Indies';
    countryMap[6] = 'Pakistan';
    countryMap[7] = 'Bangladesh';
    countryMap[8] = 'Afganistan';
    countryMap[9] = 'Zimbabwae';
    countryMap[10] = 'Kenya';
    countryMap[11] = 'Canada';
    countryMap[12] = 'UAE';
    countryMap[13] = 'United State of America';
    countryMap[14] = 'Indonesia';
    countryMap[15] = 'Africa';
    countryMap[16] = 'California';
    countryMap[17] = 'Nepal';

    return countryMap;
  }

  static showToast(String message, colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<String> downloadFile(String url, String fileName) async {
    Dio dio = Dio();
    var isGranted = await askStoragePermission();
    var path = '/storage/emulated/0/Download/$fileName.pdf';
    if (isGranted) {
      var exits = await File(path).exists();
      if (exits) {
        return 'File Already Downloaded';
      } else {
        try {
          var response = await dio.download(url, path);
          if (response.statusCode == 200) {
            return 'File Downloaded Successfully';
          } else {
            return 'Download Filed';
          }
        } catch (e) {
          return 'File Not Found';
        }
      }
    } else {
      return 'Permission Denied';
    }
  }

  static Future<bool> askStoragePermission() async {
    var status = await Permission.storage.isGranted;
    if (status) {
      return true;
    } else {
      status = await requestStoragePermission();
      return status;
    }
  }

  static Future<bool> requestStoragePermission() async {
    var isRequested = await Permission.storage.request().isGranted;
    if (isRequested) {
      return true;
    }
    return false;
  }
}
