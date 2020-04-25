import 'package:flutterapp/constant/Cv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  Preferences._();

  static void addToken(String value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Cv.TOKEN, value);
  }

  static Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(Cv.TOKEN) ?? "";
    return token;
  }

  static void addName(String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Cv.NAME, value);
  }

  static Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(Cv.NAME) ?? "";
    return stringValue;
  }

  static void addEmail(String email) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Cv.EMAIL,email);
  }

  static Future<String> getEmail() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString(Cv.EMAIL) ?? "";
    return email;
  }

  static void addPassword(String password) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Cv.PASSWORD,password);
  }

  static Future<String> getPassword() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String password = pref.getString(Cv.PASSWORD) ?? "";
    return password;
  }

  static void addPhone(String phone) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Cv.PHONE,phone);
  }

  static Future<String> getPhone() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String phone = pref.getString(Cv.PHONE) ?? "";
    return phone;
  }

  static void addUserId(int userId)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(Cv.USERID, userId);
  }

  static Future<int> getUserId() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int userId = pref.getInt(Cv.USERID) ?? 0;
    return userId;
  }

  static void addRememberMe(bool remmeberMe) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Cv.REMEMBERME, remmeberMe);
  }

  static Future<bool> getRememberMe() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool rememberMe = pref.getBool(Cv.REMEMBERME) ?? false;
    return rememberMe;
  }

  static void addForgot(bool forgot) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Cv.FORGOT, forgot);
  }

  static Future<bool> getForgot() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool rememberMe = pref.getBool(Cv.FORGOT) ?? false;
    return rememberMe;
  }

  static void addDeviceID(List<String> deviceID) async{
    SharedPreferences pref = await  SharedPreferences.getInstance();
    pref.setStringList(Cv.DEVICEID, deviceID);
  }

  static Future<List<String>> getDeviceID() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> deviceID = pref.getStringList(Cv.DEVICEID);
    return deviceID;
  }

  static void setLogin(bool login) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Cv.ISLOGIN, login);
  }

  static Future<bool> getLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool islogin = preferences.getBool(Cv.ISLOGIN) ?? false;
    return islogin;
  }
  
}