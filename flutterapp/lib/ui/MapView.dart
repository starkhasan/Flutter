import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  final Set<Marker> _marker = {
    Marker(
      position: LatLng(28.3876008, 77.312878),
      infoWindow: InfoWindow(
        title: 'Radisson Blue Fridabad',
        snippet: 'Hotel',
      ),
      markerId: MarkerId(LatLng(28.3876008, 77.312878).toString())
    )
  };
  static LatLng initialPosition;
  bool isnormal = true;
  GoogleMapController mapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.3876008, 77.312878),
    zoom: 19.151926040649414,
  );



  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(28.3876008, 77.312878),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
  );

  void currentLocation() async{
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    initialPosition = LatLng(position.latitude, position.longitude);
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _onZoomIn(){
    mapController.animateCamera(
      CameraUpdate.zoomIn()
    );
  }

  void _onZoomOut(){
    mapController.animateCamera(
      CameraUpdate.zoomOut()
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text(
          'Real Time Tracking'
        ),
      ),
      body:Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              mapType: _currentMapType,
              onMapCreated: (GoogleMapController controller){
                mapController = controller;
              },
              initialCameraPosition: _kGooglePlex,
              markers: _marker,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                     _onMapTypeButtonPressed();
                     isnormal = isnormal ? false : true; 
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(int.parse("#144473".replaceAll("#", "0xff")))
                    ),
                    child: isnormal ? Icon(Icons.satellite,color: Colors.white) : Icon(Icons.map,color: Colors.white)
                  ),
                ),
                GestureDetector(
                  onTap: _onZoomIn,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(int.parse("#144473".replaceAll("#", "0xff")))
                    ),
                    child: Icon(
                      Icons.zoom_in,color: Colors.white,
                    )
                  ),
                ),
                GestureDetector(
                  onTap: _onZoomOut,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(int.parse("#144473".replaceAll("#", "0xff")))
                    ),
                    child: Icon(
                      Icons.zoom_out,color: Colors.white,
                    )
                  ),
                )
              ],
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        onPressed: _goToTheLake,
        label: Text(
          'My Location',
          style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
        ),
        icon: Icon(Icons.directions_boat),
      )
    );
  }

  Future<void> _goToTheLake() async {
    currentLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}