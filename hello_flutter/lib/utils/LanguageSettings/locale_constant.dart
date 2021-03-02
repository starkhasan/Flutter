import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String prefDarkModeCode = 'SelectDarkMode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  return _locale(languageCode);
}

Future<void> setDark(bool brightnessCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setBool(prefDarkModeCode, brightnessCode);
}

Future<bool> getDark() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool brightnessCode = _prefs.getBool(prefDarkModeCode) ?? false;
  return brightnessCode;
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
    ? Locale(languageCode, '')
    : Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocal(context, _locale);
}

void changeDarkMode(BuildContext context, bool isDark) async {
  await setDark(isDark);
  MyApp.setDark(context, isDark);
}
