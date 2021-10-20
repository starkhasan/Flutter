import 'package:flutter/material.dart';
import 'package:notes_todo/utils/local_constant.dart';
import 'package:notes_todo/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setDark(BuildContext _context, bool isDark) {
    var myAppState = _context.findAncestorStateOfType<_MyAppState>();
    myAppState!.setDarkState(isDark);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isDark = false;

  void setDarkState(bool isDark) {
    setState(() {
      _isDark = isDark;
    });
  }

  @override
  void didChangeDependencies(){
    getDark().then((value) => setState(() => _isDark = value));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDark ? Brightness.dark : Brightness.light),
      home: SplashScreen(darkScreen: _isDark),
    );
  }
}
