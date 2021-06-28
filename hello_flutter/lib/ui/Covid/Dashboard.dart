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
    switch (index) {
      case 0:
        _title = 'Covid Status';
        break;
      case 1:
        _title = 'About Covid';
        break;
      case 2:
        _title = 'Vaccination';
        break;
      default:
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      floatingActionButton: _currentIndex == 0
      ? FloatingActionButton(
          child: Icon(Icons.calendar_today_rounded),
          onPressed: (){
            // DatePicker.showDatePicker(context,
            //     showTitleActions: true,
            //     minTime: DateTime(2018, 3, 5),
            //     maxTime: DateTime(2019, 6, 7), onChanged: (date) {
            //   print('change $date');
            // }, onConfirm: (date) {
            //   print('confirm $date');
            // }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
        )
      : null,
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
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            centerTitle: true,
            floating: true,
            title: Text(_title),
            expandedHeight: kToolbarHeight
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _listScreens[_currentIndex]
            ])
          )
        ]
      )
    );
  }
}