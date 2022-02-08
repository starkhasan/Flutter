import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/networks/response/weather_response.dart';

class ResponsiveUseInterface extends StatefulWidget {
  const ResponsiveUseInterface({Key? key}) : super(key: key);

  @override
  _ResponsiveUseInterfaceState createState() => _ResponsiveUseInterfaceState();
}

class _ResponsiveUseInterfaceState extends State<ResponsiveUseInterface> {
  
  var seconds = "00";
  var houseMinute = "00:00";
  var date = "--, -- ---";
  var counter = 0;
  WeatherResponse? weatherResponse; 
  double temperature = 0;

  @override       
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Responsive User Interface',
              style: TextStyle(fontSize: 14))),
      body: OrientationBuilder( builder: (BuildContext context, Orientation orientation) {
        return orientation == Orientation.portrait
        ? potraitScreen(context)
        : Container(color: Colors.red);
      })
    );
  }

  Widget potraitScreen(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: getTimer(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.data != null){
                var tempData = snapshot.data.toString();
                date = tempData.substring(0,10);
                seconds = tempData.substring(17,19);
                houseMinute = tempData.substring(11,16);
              }
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: houseMinute,style: const TextStyle(fontSize: 45,color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2.5)),
                    TextSpan(text: ''+seconds,style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1.5))
                  ]
                )
              );
            }
          ),
          Text(''.todayDate()),
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          Align(
            alignment: Alignment.center,
            child: Text(
              temperature == 0
              ? ''
              : (temperature - 273.15).toStringAsFixed(0)+ "\u2103",
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 45,color: Colors.black)
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(Icons.cloud, size: 80),
          )
        ]
      )
    );
  }

  Stream<DateTime> getTimer() async* {
    while(true){
      if(counter == 0){
        counter++;
        callAfterFive();
      }else{
        counter++;
        if(counter == 60) counter = 0;
      }
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now();
    }
  }


  void callAfterFive() async{
    final p = ReceivePort();
    await Isolate.spawn(backgroundTask, p.sendPort);
    p.first.then((value){
      if(value != null){
        setState(() => temperature = value);
      }
    });
  }


}

extension ConvertDateTime on String{
  String todayDate() {
    var day = DateFormat('EEE, d MM').format(DateTime.now());
    switch (day.substring(7)) {
      case '01':
        return day = day.substring(0,7) + 'Jan';
      case '02':
        return day = day.substring(0,7) + 'Feb';
      case '03':
        return day = day.substring(0,7) + 'Mar';
      case '04':
        return day = day.substring(0,7) + 'Apr';
      case '05':
        return day = day.substring(0,7) + 'May';
      case '06':
        return day = day.substring(0,7) + 'Jun';
      case '07':
        return day = day.substring(0,7) + 'Jul';
      case '08':
        return day = day.substring(0,7) + 'Aug';
      case '09':
        return day = day.substring(0,7) + 'Sep';
      case '10':
        return day = day.substring(0,7) + 'Oct';
      case '11':
        return day = day.substring(0,7) + 'Nov';
      case '12':
        return day = day.substring(0,7) + 'Dec';
      default:
        return 'Error';
    }
  }
}


Future backgroundTask(SendPort p) async {
  try {
    var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Arrah&appid=e661b5089b025ac13a439a48b73ae5cf'));
    if(response.statusCode == 200){
      var weatherResponse = WeatherResponse.fromJson(jsonDecode(response.body));
      Isolate.exit(p,weatherResponse.main.feelsLike);
    }else{
      Isolate.exit(p,null);
    }
  } catch (e) {
    Isolate.exit(p,null); 
  }
}