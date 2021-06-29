import 'package:flutter/material.dart';
import 'package:covid_info/ui/AboutCovid.dart';
import 'package:covid_info/ui/CovidStatus.dart';
import 'package:covid_info/ui/Vaccination.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var _currentIndex = 0;
  
  var _listScreens = [
    CovidStatus(),
    Vaccination(),
    AboutCovid()
  ];

  onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
          )
        ]
      ),
      body: _listScreens[_currentIndex]
    );
  }
}