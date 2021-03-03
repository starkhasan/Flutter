import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hello_flutter/ui/splash.dart';
import 'package:hello_flutter/utils/LanguageSettings/AppLocalizationsDelegate.dart';
import 'package:hello_flutter/utils/LanguageSettings/locale_constant.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocal(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyApp>();
    state.setLocale(newLocale);
  }

  static void setDark(BuildContext context, bool isDark) {
    var state = context.findAncestorStateOfType<_MyApp>();
    state.setDarkMode(isDark);
  }

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Locale _locale;
  bool _isDark = false;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setDarkMode(bool isdark) {
    setState(() {
      _isDark = isdark;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    getDark().then((value) {
      _isDark = value;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: _isDark ? Brightness.dark : Brightness.light),
      locale: _locale,
      home: Spalsh(),
      supportedLocales: [Locale('en', ''), Locale('hi', '')],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
    );
  }
}
