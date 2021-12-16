import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _sharedPreferences;
  static Future<SharedPreferences> get _instance async => _sharedPreferences ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _sharedPreferences = await _instance;
    return _sharedPreferences;
  }

  static List<String> getStoredTask() {
    return _sharedPreferences!.getStringList('TASK') ?? [];
  }

  static void storeTask(List<String> task) {
    _sharedPreferences!.setStringList('TASK', task);
  }

  static List<String> getCompleteTask() {
    return _sharedPreferences!.getStringList('COMPLETE_TASK') ?? [];
  }

  static void storeCompleteTask(List<String> completeTask) {
    _sharedPreferences!.setStringList('COMPLETE_TASK', completeTask);
  }

  static void setUserLogin(bool isLogin) {
    _sharedPreferences!.setBool('USER_LOGIN', isLogin);
  }

  static bool getUserLogin() {
    return _sharedPreferences!.getBool('USER_LOGIN') ?? false;
  }

  static void setUserID(String userId) {
    _sharedPreferences!.setString('USER_ID', userId);
  }

  static String getUserID() {
    return _sharedPreferences!.getString('USER_ID') ?? '';
  }

  static bool getSyncEnabled() {
    return _sharedPreferences!.getBool('SYNC_DATA') ?? false;
  }

  static void setSyncEnabled(bool sync) {
    _sharedPreferences!.setBool('SYNC_DATA', sync);
  }

  static void setUserEmail(String email) {
    _sharedPreferences!.setString('USER_EMAIL', email);
  }

  static String getUserEmail() {
    return _sharedPreferences!.getString('USER_EMAIL') ?? '';
  }

  static bool getLocalDeleted() {
    return _sharedPreferences!.getBool('LOCAL_DELETE') ?? false;
  }

  static void setLocalDelete(bool localDelete) {
    _sharedPreferences!.setBool('LOCAL_DELETE', localDelete);
  }

  static bool getSyncExplicitly() {
    return _sharedPreferences!.getBool('SYNC_DATA_EXPLICIT') ?? false;
  }

  static void setSyncExplicitly(bool sync) {
    _sharedPreferences!.setBool('SYNC_DATA_EXPLICIT', sync);
  }

  static void setUserName(String name) async {
    _sharedPreferences!.setString('USER_NAME', name);
  }

  static String getUserName() {
    return _sharedPreferences!.getString('USER_NAME') ?? '';
  }

  static bool getAppTheme() {
    return _sharedPreferences!.getBool('APP_THEME') ?? false;
  }

  static void setAppTheme(bool theme) {
    _sharedPreferences!.setBool('APP_THEME', theme);
  }
}
