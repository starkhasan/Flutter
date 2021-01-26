import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';

class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      loadingText: 'Loading...',
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Pie Chart'),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Text('Pie Chart'),
          ),
        ),
      ),
    );
  }
}