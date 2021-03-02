import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:convert' show utf8, base64;
import 'dart:ui';
import 'package:http/http.dart' as http;

class GoogleMapRoute extends StatefulWidget {
  GoogleMapRoute({this.initialPostion});
  final Position initialPostion;
  @override
  _GoogleMapRouteState createState() => _GoogleMapRouteState();
}

class _GoogleMapRouteState extends State<GoogleMapRoute>
    with WidgetsBindingObserver {
  var address = "Wali Ganj Arrah";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  var markerCount = 1;
  MarkerId firstId = MarkerId('First');
  MarkerId secondId = MarkerId('Second');
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  var infoWindowResponse;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      mapController.setMapStyle('[]');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      loadingText: 'Loading...',
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Map Route'),
        ),
        body: Container(
            child: GoogleMap(
          polylines: Set.from(polylines.values),
          markers: Set.from(markers.values),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialPostion.latitude,
                  widget.initialPostion.longitude),
              zoom: 14.0),
          onMapCreated: (GoogleMapController _controller) {
            setState(() {
              mapController = _controller;
            });
          },
          onTap: (position) {
            if (markerCount > 2) {
              setState(() {
                markerCount = 1;
                markers.clear();
                polylines.clear();
              });
            } else {
              markerCount == 1
                  ? _addMarker(position, firstId)
                  : _addMarker(position, secondId);
            }
          },
        )),
      ),
    );
  }

  void infoWindowApi(LatLng location, MarkerId id, String address) async {
    var url = "https://textoverimage.moesif.com/image?image_url=https://i.ibb.co/jL1DkDx/pickup.png&text=$address&text_size=32&x_align=center&text_color=%2333af3bff&margin=20";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Marker marker = Marker(
        markerId: id,
        position: location,
        draggable: false,
        icon: BitmapDescriptor.fromBytes(response.bodyBytes),
        infoWindow: InfoWindow(title: 'Home', snippet: 'Wali Ganj, Arrah'),
      );
      setState(() {
        markers[id] = marker;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 14.0)));
        markerCount += 1;
      });
      if (markerCount > 2) _drawRoute();
    } else {
      Marker marker = Marker(
        markerId: id,
        position: location,
        draggable: false,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Home', snippet: 'Wali Ganj, Arrah'),
      );
      setState(() {
        markers[id] = marker;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 14.0)));
        markerCount += 1;
      });
      if (markerCount > 2) _drawRoute();
    }
  }

  _addMarker(LatLng location, MarkerId id) {
    infoWindowApi(location, id, 'Hello this is ali hasan');
  }

  _drawRoute() async {
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBp7D1ltNA_ko5YToxljvblz_Ffg0v0OZU',
        PointLatLng(markers[firstId].position.latitude,
            markers[firstId].position.longitude),
        PointLatLng(markers[secondId].position.latitude,
            markers[secondId].position.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId polyId = PolylineId('Home');
    Polyline polyline = Polyline(
        polylineId: polyId,
        color: Colors.lightBlue,
        width: 5,
        points: polylineCoordinates);
    setState(() {
      polylines[polyId] = polyline;
    });
  }
}
