import 'dart:developer';

import 'package:block_arch/cubit/counter_cubit.dart';
import 'package:block_arch/ui/counter_cubit_screen.dart';
import 'package:block_arch/ui/first_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CunterCubitScreen()
    );
  }
}
