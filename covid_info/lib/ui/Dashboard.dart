import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_info/ui/AboutCovid.dart';
import 'package:covid_info/ui/CovidStatus.dart';
import 'package:covid_info/ui/Vaccination.dart';
import 'package:covid_info/ui/FAQScreen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var _currentIndex = 0;
  
  var _listScreens = [
    CovidStatus(),
    Vaccination(),
    AboutCovid(),
    FAQScreen()
  ];

  onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Colors.white,
          backgroundColor: Color(0xFF0B3054),
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          onTap: onTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Status',
              icon: Icon(Icons.equalizer_outlined)
            ),
            BottomNavigationBarItem(
              label: 'Vaccination',
              icon: Icon(Icons.local_hospital)
            ),
            BottomNavigationBarItem(
              label: 'About Corona',
              icon: Icon(Icons.info)
            ),
            BottomNavigationBarItem(
              label: 'FAQs',
              icon: Icon(Icons.question_answer_rounded)
            )
          ]
        ),
        body: _listScreens[_currentIndex]
      ),
      onWillPop: onBackPress
    );
  }

  Future<bool> onBackPress() async{
    return await showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('Exit'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No',style: TextStyle(color: Colors.red))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes'),
            )
          ]
        );
      }
    );
  }
}