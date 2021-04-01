import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hello_flutter/ui/BarChartModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'indicator.dart';

class PieChartSample extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChartSample> {

  int touchedIndex;
  List<BarChartModel> graphData = [
    BarChartModel(
      year: "2014",
      financial: 250,
      color: charts.ColorUtil.fromDartColor
      (Color(0xFF47505F)),
    ),
    BarChartModel(
      year: "2015",
      financial: 300,
      color: charts.ColorUtil.fromDartColor
      (Colors.red),
    ),
    BarChartModel(
      year: "2016",
      financial: 100,
      color: charts.ColorUtil.fromDartColor
      (Colors.green),
    ),
    BarChartModel(
      year: "2017",
      financial: 450,
      color: charts.ColorUtil.fromDartColor
      (Colors.yellow),
    ),
    BarChartModel(
      year: "2018",
      financial: 630,
      color: charts.ColorUtil.fromDartColor
      (Colors.lightBlueAccent),
    ),
    BarChartModel(
      year: "2019",
      financial: 1000,
      color: charts.ColorUtil.fromDartColor
      (Colors.pink),
    ),
    BarChartModel(
      year: "2020",
      financial: 500,
      color: charts.ColorUtil.fromDartColor
      (Colors.purple),
    ),
  ];


  List<charts.Series<BarChartModel, String>> getList(){
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "Financial",
        data: graphData,
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color
      ),
    ];

    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                              if (desiredTouch && pieTouchResponse.touchedSection != null) {
                                touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                              } else {
                                touchedIndex = -1;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections()),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Indicator(
                      color: Color(0xff0293ee),
                      text: 'First',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xfff8b250),
                      text: 'Second',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xff845bef),
                      text: 'Third',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xff13d38e),
                      text: 'Fourth',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: charts.BarChart(
                getList(),
                animate: true
              )
            )
          ],
        ),
      )
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}