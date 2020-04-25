import 'dart:convert';

import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/network/response/GetLocationResponse.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';

class RealTimeTracking extends StatefulWidget {
  @override
  _RealTimeTrackingState createState() => _RealTimeTrackingState();
}

class _RealTimeTrackingState extends State<RealTimeTracking> {

  bool isnormal = true;
  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> _mapPolylines = {};
  LatLng newPosition;
  List<LatLng> polylinesList = [];

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }


  void startTimer(){
    var cd = CountDown(Duration(seconds : 10));
    var sub = cd.stream.listen(null);
    sub.onData((Duration d) {});
    sub.onDone(() {
        apiCall();
    });
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  void apiCall(){
    polylinesList.clear();
    fetchData().then((result){
      if(jsonDecode(result)['status'] == 200){
        var response = GetLocationResponse.fromJson(json.decode(result));
        if(response.status == 200){
          for(var i=0;i<response.pets.length;i++) {
            if(response.pets[i].locationDetails.deviceDate!=null && response.pets[i].locationDetails.battery!=null){
              polylinesList.add(LatLng(response.pets[i].locationDetails.lat,response.pets[i].locationDetails.lon));
              final PolylineId polylineId = PolylineId(response.pets[i].name);
              final MarkerId markerId = MarkerId(response.pets[i].name);
              final Marker marker = Marker(
                markerId: markerId,
                position: LatLng(response.pets[i].locationDetails.lat,response.pets[i].locationDetails.lon),
                infoWindow: InfoWindow(
                  title: response.pets[i].name,
                  snippet: 'Battery ${response.pets[i].locationDetails.battery}% ${response.pets[i].locationDetails.deviceDate}'
                ),
              );
              final Polyline polyline = Polyline(
                polylineId: polylineId,
                consumeTapEvents: true,
                color: Colors.red,
                width: 5,
                points: polylinesList,
              );
              setState(() {
                markers[markerId] = marker;
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(response.pets[i].locationDetails.lat,response.pets[i].locationDetails.lon),
                    zoom: 10.0
                  )
                ));
                _mapPolylines[polylineId] = polyline;
              });
            }
          }
          startTimer();
        }else{
          Toast.show(response.message,context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
        }
      }else{
        Toast.show(jsonDecode(result)['message'], context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      }
    });
  }

  fetchData(){
    return ApiService.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text(
          'Real Time Tracking'
        )
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              compassEnabled: true,
              mapType: _currentMapType,
              onMapCreated: (GoogleMapController controller){
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(28.3876008, 77.312878),
                zoom: 19.151926040649414,
              ),
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(_mapPolylines.values),  
            )
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                     _onMapTypeButtonPressed();
                     isnormal = isnormal ? false : true; 
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(int.parse("#144473".replaceAll("#", "0xff")))
                    ),
                    child: isnormal ? Icon(Icons.satellite,color: Colors.white) : Icon(Icons.map,color: Colors.white)
                  )
                )
              ]
            )
          )
        ]
      )    
    );
  }
}