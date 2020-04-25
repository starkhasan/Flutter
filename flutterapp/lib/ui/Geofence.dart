import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/GeofenceResponse.dart';
import 'package:flutterapp/ui/AddGeofence.dart';
import 'package:toast/toast.dart';

class Geofence extends StatefulWidget {
  @override
  _GeofenceState createState() => _GeofenceState();
}

class _GeofenceState extends State<Geofence> {

  List<Geofance> geofence = [];

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  void apiCall(){
    fetchData().then((result){
      if(jsonDecode(result)['status'] == 200 && jsonDecode(result)['message'] != "No pets..please add pets details"){
        var response = GeofenceResponse.fromJson(jsonDecode(result));
        if(response.status == 200 ){
          setState(() {
            geofence = response.geofances;
          });
        }else{
          Toast.show(response.message, context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
        }
      }else{
        Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      }
    });
  }

  fetchData(){
    return ApiService.getGeofence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        title: Text("Geofence"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> AddGeofence()));
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: geofence.length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      dense: false,
                      title: Text(
                        geofence[index].name,
                        style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                      ),
                      subtitle: Text(
                        'Device : '+geofence[index].deviceId,
                        style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          /*String _petsDetails="";
                          _petsDetails = geofence[index].deviceId;
                          _petsDetails = _petsDetails +"/"+geofence[index].name;
                          _petsDetails = _petsDetails +"/"+geofence[index].animalType;
                          if(geofence[index].breed == null || geofence[index].breed == ""){
                            _petsDetails = _petsDetails +"/"+" ";
                          }else{
                            _petsDetails = _petsDetails +"/"+petResponse[index].breed;
                          }

                          if(petResponse[index].birthday == null || petResponse[index].birthday == ""){
                            _petsDetails = _petsDetails +"/"+" ";
                          }else{
                            _petsDetails = _petsDetails +"/"+petResponse[index].birthday;
                            
                          }
                          _petsDetails = _petsDetails+"/"+petResponse[index].id.toString();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPetDetailsActivity(text:_petsDetails)));
                          */
                          Toast.show('Clicked',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                        },
                      ),
                    )
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}