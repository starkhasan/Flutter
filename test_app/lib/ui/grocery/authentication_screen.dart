import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app/utils/page_view_label_indicator.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({ Key? key }) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;
  List<String>  page = ['Signup','Signin'];
  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),child: const Center(child: Text('Grocery Plus',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)))),
            PageViewLabelIndicator(
              label: page,
              currentPageNotifier: currentPageNotifier,
              selectedColor: Colors.green
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              margin: const EdgeInsets.all(5),
              child: PageView(
                children: List.generate(2, (index) => Container(color: Colors.primaries[Random().nextInt(Colors.primaries.length)])),
                onPageChanged: (value) => currentPageNotifier.value = value,
              ),
            )
          ]
        )
      )
    );
  }
}