import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/prvoider/favorites_provider.dart';
import 'package:testing_app/view/hom_screen.dart';

class TestingApp extends StatelessWidget {
  const TestingApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesPovider>(
      create: (context) => FavoritesPovider(),
      child: MaterialApp(
        title: 'Testing Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home: const HomeScreen()
      )
    );
  }
}