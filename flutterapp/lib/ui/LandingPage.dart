import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/GetLocationResponse.dart';
import 'package:flutterapp/ui/Geofence.dart';
import 'package:flutterapp/ui/HistoricalRoute.dart';
import 'package:flutterapp/ui/RealTimeTracking.dart';
import 'package:flutterapp/ui/Settings.dart';
import 'package:flutterapp/utils/CircularDialog.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:flutterapp/utils/drawer.dart';
import 'package:toast/toast.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var dialog;

  @override
  void initState(){
    fetchData().then((result){
      if(jsonDecode(result)['status'] == 200){
        var response = GetLocationResponse.fromJson(json.decode(result));
        if(response.status == 200){
          List<String> deviceID = [];
          Preferences.addDeviceID(deviceID);
          for(var i=0;i<response.pets.length;i++){
            deviceID.add(response.pets[i].deviceId);
          }
          Preferences.addDeviceID(deviceID);
        }else{
          Toast.show(response.message,context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
        }
      }else{
        Toast.show(jsonDecode(result)['message'],context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      }
    });
    super.initState();
  }


  fetchData(){
    return ApiService.getLocation();
  }


  @override
  Widget build(BuildContext context) {
    dialog = CircularDialog.progressDialog(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/doglanding.png'),fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: DrawerLayout(),
          appBar: AppBar(
            backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
            centerTitle: true,
            title: Text(
              'Folloh'
            )
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RealTimeTracking())),
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(int.parse("#D0E6E3E3".replaceAll("#","0xff")))
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child:Image.asset(
                                  'assets/images/Real_time.png',
                                  fit:BoxFit.cover,
                                  height: 80.0,
                                  width: 80.0,
                                )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Real Time Tracking',
                                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                              )
                            ]
                          )
                        )
                      )
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoricalRoute()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(int.parse("#D0E6E3E3".replaceAll("#","0xff")))
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child:Image.asset(
                                  'assets/images/historical.png',
                                  fit:BoxFit.cover,
                                  height: 80.0,
                                  width: 80.0,
                                )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Historical Route',
                                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                              )
                            ]
                          )
                        )
                      )
                    )
                  ]
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Geofence())),
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(int.parse("#D0E6E3E3".replaceAll("#","0xff")))
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child:Image.asset(
                                  'assets/images/Geofence.png',
                                  fit:BoxFit.cover,
                                  height: 80.0,
                                  width: 80.0,
                                )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Geofence',
                                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                              )
                            ]
                          )
                        )
                      )
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Settings())),
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(int.parse("#D0E6E3E3".replaceAll("#","0xff")))
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child:Image.asset(
                                  'assets/images/settings.png',
                                  fit:BoxFit.cover,
                                  height: 80.0,
                                  width: 80.0,
                                )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Setting',
                                style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                              )
                            ]
                          )
                        )
                      )
                    )
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}