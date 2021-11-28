import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      target: LatLng(25.568369, 84.684380),
      tilt: 0.0,
      zoom: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,

        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => goToTheLake(),
        label: const Text('To the lake!'),
        icon:  const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> goToTheLake() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
