import 'package:covid_info/controllers/covid_status_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_info/ui/about_covid_screen.dart';
import 'package:covid_info/ui/covid_status_screen.dart';
import 'package:covid_info/ui/vaccination_screen.dart';
import 'package:covid_info/ui/faq_screen.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidStatusProvider>(
      create: (context) => CovidStatusProvider(),
      child: Consumer<CovidStatusProvider>(
          builder: (context, covidProvider, child) {
        return MainScreen(provider: covidProvider);
      }),
    );
  }
}

class MainScreen extends StatefulWidget {
  final CovidStatusProvider provider;
  MainScreen({required this.provider});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver{

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
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    widget.provider.userCount(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed)
      widget.provider.userCount(true);
    if(state == AppLifecycleState.paused)
      widget.provider.userCount(false);
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
              icon: Icon(Icons.equalizer_outlined,size: 18)
            ),
            BottomNavigationBarItem(
              label: 'Vaccination',
              icon: Icon(Icons.local_hospital,size: 18)
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: Icon(Icons.coronavirus_rounded,size: 18)
            ),
            BottomNavigationBarItem(
              label: 'FAQs',
              icon: Icon(Icons.question_answer_rounded,size: 18)
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
              onPressed: () async{
                await widget.provider.userCount(false);
                Navigator.pop(context, true);
              },  
              child: Text('Yes'),
            )
          ]
        );
      }
    );
  }
}
