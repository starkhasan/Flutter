import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/utils/LanguageSettings/LanguageEn.dart';
import 'package:hello_flutter/utils/LanguageSettings/LanguageHindi.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en','hi'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'hi':
        return LanguageHindi();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
  
}