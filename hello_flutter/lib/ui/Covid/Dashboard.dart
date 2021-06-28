import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/Covid/AboutCovid.dart';
import 'package:hello_flutter/ui/Covid/CovidStatus.dart';
import 'package:hello_flutter/ui/Covid/Vaccination.dart';
import 'package:hello_flutter/utils/HomeDrawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var _currentIndex = 0;
  var _title = 'Covid Status';
   

  var _listScreens = [
    CovidStatus(),
    AboutCovid(),
    Vaccination()
  ];

  onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Status',
            icon: Icon(Icons.stacked_bar_chart)
          ),
          BottomNavigationBarItem(
            label: 'About',
            icon: Icon(Icons.info)
          ),
          BottomNavigationBarItem(
            label: 'Vaccination',
            icon: Icon(Icons.health_and_safety_rounded)
          )
        ]
      ),
      body: _listScreens[_currentIndex]
    );
  }
}