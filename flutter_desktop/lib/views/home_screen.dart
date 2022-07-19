import 'package:flutter/material.dart';
import '../views/desktop_view/desktop_dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth <= 500){
          return Container(
            child: Center(child: Text('Mobile Phone')),
          );
        } else if(constraints.maxWidth > 500 && constraints.maxWidth <= 900){
          return Container(
            child: Center(child: Text('Tablet Phone')),
          );
        } else{
          return const DektopDashboardScreen();
        }
      }),
    );
  }
}