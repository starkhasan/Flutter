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

  static void setImagePath(String value) async {
    pref = await SharedPreferences.getInstance();
    pref.setString(Cv.USERIMAGE, value);
  }

  static Future<String> getImagePath() async {
    pref = await SharedPreferences.getInstance();
    String imagePath = pref.getString(Cv.USERIMAGE) ?? '';
    return imagePath;
  }

  static void setGoogleImage(String value) async {
    pref = await SharedPreferences.getInstance();
    pref.setString(Cv.GOOGLEPROFILE, value);
  }

  static Future<String> getGoogleImage() async {
    pref = await SharedPreferences.getInstance();
    String imagePath = pref.getString(Cv.GOOGLEPROFILE) ?? '';
    return imagePath;
  }

  static void setSenderName(String sender) async {
    pref = await SharedPreferences.getInstance();
    pref.setString(Cv.SENDER_USER, sender);
  }

  static Future<String> getSenderName() async {
    pref = await SharedPreferences.getInstance();
    String senderName = pref.getString(Cv.SENDER_USER) ?? '';
    return senderName;
  }

  static void setVirtualLogin(bool login) async {
    pref = await SharedPreferences.getInstance();
    pref.setBool(Cv.VIRTUAL_LOGIN, login);
  }

  static Future<bool> getVirtualLogin() async {
    pref = await SharedPreferences.getInstance();
    bool login = pref.getBool(Cv.VIRTUAL_LOGIN) ?? false;
    return login;
  }
}
