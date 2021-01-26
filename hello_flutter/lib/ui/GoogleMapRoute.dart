import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapRoute extends StatefulWidget {
  GoogleMapRoute({this.initialPostion});
  final Position initialPostion;
  @override
  _GoogleMapRouteState createState() => _GoogleMapRouteState();
}

class _GoogleMapRouteState extends State<GoogleMapRoute>
    with WidgetsBindingObserver {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  var markerCount = 1;
  MarkerId firstId = MarkerId('First');
  MarkerId secondId = MarkerId('Second');
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

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

  _addMarker(LatLng location, MarkerId id) {
    Marker marker = Marker(
      markerId: id,
      position: location,
      draggable: false,
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

  _drawRoute() async {
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'YOUR_GOOGLE_API_KEY',
        PointLatLng(markers[firstId].position.latitude,
            markers[firstId].position.longitude),
        PointLatLng(markers[secondId].position.latitude,
            markers[secondId].position.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Wali Ganj, Arrah")]);
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
      points: polylineCoordinates
    );
    setState(() {
      polylines[polyId] = polyline;
    });
  }
}
