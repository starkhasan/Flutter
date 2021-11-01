import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _sharedPreferences;

  static Future<SharedPreferences> get _instance async => _sharedPreferences ?? await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _sharedPreferences = await _instance;
    return _sharedPreferences;
  }

  static void setUserId(String userId) {
    _sharedPreferences!.setString('USER_ID', userId);
  }

  static String getUserId() {
    return _sharedPreferences!.getString('USER_ID') ?? '';
  }

  static void setInventoryName(String inventoryName) {
    _sharedPreferences!.setString('INVENTORY_NAME', inventoryName);
  }

  static String getInventoryName() {
    return _sharedPreferences!.getString('INVENTORY_NAME') ?? '';
  }

  static void setLogin(bool loginUser) {
    _sharedPreferences!.setBool('USER_LOGIN', loginUser);
  }

  static bool getLogin() {
    return _sharedPreferences!.getBool('USER_LOGIN') ?? false;
  }
}
