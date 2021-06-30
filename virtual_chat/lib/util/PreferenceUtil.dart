import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_chat/util/Cv.dart';

class PreferenceUtil {
  static SharedPreferences? _sharedPreferenes;
  static Future<SharedPreferences> get _instance async =>
      _sharedPreferenes ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _sharedPreferenes = await _instance;
    return _sharedPreferenes;
  }

  static String getSenderName() {
    return _sharedPreferenes!.getString(Cv.SENDER_NAME) ?? "";
  }

  static void setSenderName(String sender) {
    _sharedPreferenes!.setString(Cv.SENDER_NAME, sender);
  }

  static bool getLogin() {
    return _sharedPreferenes!.getBool(Cv.LOGIN) ?? false;
  }

  static void setLogin(bool login) {
    _sharedPreferenes!.setBool(Cv.LOGIN, login);
  }
}
