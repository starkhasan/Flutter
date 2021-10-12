import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _sharedPreferences;
  static Future<SharedPreferences> get _instance async =>
      _sharedPreferences ??= await SharedPreferences.getInstance();

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
}
