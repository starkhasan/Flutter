import 'package:flutter/material.dart';
import 'package:flutterapp/ui/Geofence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';

class AddGeofence extends StatefulWidget {
  @override
  _AddGeofenceState createState() => _AddGeofenceState();
}

class _AddGeofenceState extends State<AddGeofence> {

  GoogleMapController mapController;
  Set<Marker> _markers;

  Future<bool> _backPressed(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Geofence()));
  }

  _handleTap(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
          title: Text('Add Geofence'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_forever), 
              onPressed: () => Toast.show('Clicked',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM)
            )
          ],
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Geofence())),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: GoogleMap(
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller){
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(28.3876008, 77.312878),
                  zoom: 19.151926040649414,
                ),
                markers: _markers
              )
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Select DeviceID',
                            style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                          ),
                          SizedBox(height:5.0),
                          TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                            decoration: InputDecoration(
                              hintText: 'Enter Device ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Geofancing Name',
                            style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 14.0),
                          ),
                          SizedBox(height:5.0),
                          TextField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black,fontFamily: 'MontserratRegular',fontSize: 16.0),
                            decoration: InputDecoration(
                              hintText: 'Geofancing Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            )
          ]
        )
      )
    );
  }
}