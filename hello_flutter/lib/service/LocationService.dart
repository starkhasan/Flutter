import 'dart:async';

import 'package:hello_flutter/network/response/UserLocation.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;

  StreamController<UserLocation> _locationController = StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;


  var location = Location();
  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(latitude: userLocation.latitude, lonitude: userLocation.longitude);
    } on Exception catch (e) {
      print("Couldn't get the location");
    }
    return _currentLocation;
  }

  LocationService(){  
    location.requestPermission().then((granted){
      if(granted != null){
        location.onLocationChanged.listen((locationData) { 
          if(locationData!=null){
            _locationController.add(UserLocation(latitude: locationData.latitude,lonitude: locationData.longitude));
          }
        });
      }
    });
  }

  
}
