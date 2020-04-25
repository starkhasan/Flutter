import 'package:flutter/material.dart';
import 'package:flutterapp/network/response/GetAllLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';


class PlayBack extends StatefulWidget {


  List<DeviceDetail> list = [];
  PlayBack({Key key, this.list}) : super(key: key);


  @override
  _PlayBackState createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {

  bool isnormal = true;
  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> _mapPolylines = {};


  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }


  @override
  void initState() {
    var size = widget.list;
    print('size${size.length.toString()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        title: Text('Play Back'),
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
        ],
      )
    );
  }
}