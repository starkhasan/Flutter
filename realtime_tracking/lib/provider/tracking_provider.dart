import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingProvider extends ChangeNotifier {
  LatLng trackPosition = const LatLng(25.568369, 84.684380);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId senderMarkerId = const MarkerId('sender');

  updateMarker(Marker marker, LatLng position) {
    markers[senderMarkerId] = marker;
    trackPosition = position;
    notifyListeners();
  }
}
