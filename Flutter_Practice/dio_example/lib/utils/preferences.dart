import 'package:dio_example/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _sharedPreferences;
  static Future<SharedPreferences> get _instance async => _sharedPreferences ?? await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _sharedPreferences = await _instance;
    return _sharedPreferences;
  }

  //user token
  static void setToken(String value) => _sharedPreferences!.setString(Strings.userToken, value);

  static String getToken() => _sharedPreferences!.getString(Strings.userToken) ?? "";

}
