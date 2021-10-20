import 'package:flutter/material.dart';
import 'package:notes_todo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefDarkModeCode = 'SelectDarkMode';

Future<void> setDark(bool brightnessCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setBool(prefDarkModeCode, brightnessCode);
}

Future<bool> getDark() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool brightnessCode = _prefs.getBool(prefDarkModeCode) ?? false;
  return brightnessCode;
}

void changeDarkMode(BuildContext context, bool isDark) async {
  await setDark(isDark);
  MyApp.setDark(context, isDark);
}
