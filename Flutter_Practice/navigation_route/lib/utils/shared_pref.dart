import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // SharedPref();
  // static final SharedPref _instance = SharedPref();
  // factory SharedPref.init() {
  //   return _instance;
  // }

  static SharedPreferences? _sharedPreferences;
  static Future<SharedPreferences> get _instance async => _sharedPreferences ?? await SharedPreferences.getInstance();

  // static Future<SharedPreferences> _instance() async {
  //   return _sharedPreferences ??= await SharedPreferences.getInstance();
  // }

  static Future<SharedPreferences?> init() async {
    return _instance;
  }

  // factory SharedPreferences{
  //   return _instance;
  // }
}
