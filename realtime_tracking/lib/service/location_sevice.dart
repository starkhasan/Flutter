import 'dart:async';

import 'package:location/location.dart';
import 'package:realtime_tracking/model/location_model.dart';
import 'package:geolocator/geolocator.dart';
class LocationService{
  
  var location = Location();
  var currentLocation = LocationModel(0.0, 0.0);

  StreamController<LocationModel> locationStreamController = StreamController<LocationModel>();
  Stream<LocationModel> get locationStream => locationStreamController.stream;

  Future<LocationModel> getCurrentLocation() async{
    try {
      var locationData = await location.getLocation();
      currentLocation = LocationModel(locationData.latitude!, locationData.longitude!);
    } on Exception {
      currentLocation = LocationModel(0.0, 0.0);
    }
    return currentLocation;
  }


  Future<LocationModel> getCurrentLocationGeoLocator() async{
    var position = await Geolocator.getCurrentPosition();
    currentLocation = LocationModel(position.latitude, position.longitude);
    return currentLocation;

  }

  LocationService(){
    location.requestPermission().then((granted){
      if(granted != null){
        location.onLocationChanged.listen((locationData) { 
          if(locationData != null){
            locationStreamController.add(LocationModel(locationData.latitude!, locationData.longitude!));
          }
        });
      }
    });
  }
}