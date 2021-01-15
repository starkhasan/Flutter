import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_flutter/constants/Cv.dart';

class Preferences {
  Preferences._();

  static SharedPreferences pref;

  static void setLogin(bool value) async {
    pref = await SharedPreferences.getInstance();
    pref.setBool(Cv.ISLOGIN, value);
  }

  static Future<bool> getLogin() async {
    pref = await SharedPreferences.getInstance();
    bool value = pref.getBool(Cv.ISLOGIN) ?? false;
    return value;
  }

  static void setName(String name) async {
    pref = await SharedPreferences.getInstance();
    pref.setString(Cv.USERNAME, name);
  }

  static Future<String> getName() async {
    pref = await SharedPreferences.getInstance();
    String name = pref.getString(Cv.USERNAME) ?? "";
    return name;
  }

  static void setImagePath(dynamic value) async {
    pref = await SharedPreferences.getInstance();
    pref.setString(Cv.USERIMAGE, value);
  }

  static Future<dynamic> getImagePath() async {
    pref = await SharedPreferences.getInstance();
    dynamic imagePath = pref.getString(Cv.USERIMAGE) ?? null;
    return imagePath;
  }
}
