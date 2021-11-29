import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RealTimeTracking extends StatelessWidget {
  final String currentUserId;
  final String senderId;
  const RealTimeTracking({Key? key, required this.currentUserId, required this.senderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainRealTimeTrackingScreen(currentUser: currentUserId, senderUser: senderId);
  }
}

class MainRealTimeTrackingScreen extends StatefulWidget {
  final String currentUser;
  final String senderUser;
  const MainRealTimeTrackingScreen({Key? key, required this.currentUser, required this.senderUser}) : super(key: key);

  @override
  _MainRealTimeTrackingScreenState createState() => _MainRealTimeTrackingScreenState();
}

class _MainRealTimeTrackingScreenState extends State<MainRealTimeTrackingScreen> {
  final double cameraZoom = 16;
  final double cameraTilt = 80;
  final double cameraBearing = 30;
  final LatLng destLocation = const LatLng(25.565732, 84.671338);
  final LatLng sourceLocation = const LatLng(25.568365, 84.684363);
  late Location location;

  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId sourcePin = const MarkerId('source');
  MarkerId destinationPin = const MarkerId('destination');
  MarkerId updatedPin = const MarkerId('update');


  @override
  void initState() {
    super.initState();

    location = Location();
    location.onLocationChanged.listen((LocationData loc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      //updatePinOnMap(LatLng(loc.latitude!, loc.longitude!));
    });


    FirebaseFirestore.instance.collection('users').doc('979234').snapshots().listen((event) { 
      var data = event.data()!;
      updatePinOnMap(LatLng(data['userLocation'].latitude,data['userLocation'].longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Realtime Tracking')),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            initialCameraPosition: const CameraPosition(target: LatLng(25.568369, 84.684380), zoom: 14.0),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              //showPinsOnMap();
            },
            markers: Set.from(markers.values),
          )
        ]
      )
    );
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    markers[sourcePin] = Marker(markerId: sourcePin, position: sourceLocation);

    // get a LatLng out of the LocationData object
    markers[destinationPin] = Marker(markerId: destinationPin, position: destLocation);
    // add the initial source location pin
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setState(() {});
  }

  void updatePinOnMap(LatLng newPosition) async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: cameraZoom,
      tilt: cameraTilt,
      bearing: cameraBearing,
      target: newPosition,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      markers[updatedPin] = Marker(markerId: updatedPin, position: newPosition,infoWindow: const InfoWindow(title: 'Updated Position'));
    });
  }
}
