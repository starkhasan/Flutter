import 'dart:async';


class CounterStream {
  int count = 0;
  var position = '';
  // final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  // StreamSubscription<Position>? positionStreamSubscription;
  // final LocationSettings locationSettings = const LocationSettings(accuracy: LocationAccuracy.low);
  StreamController<String> streamController = StreamController<String>();
  Stream<String> get positionStream => streamController.stream;

  Stream<int> getCounter() async* {
    while (count < 100) {
      count++;
      await Future.delayed(const Duration(seconds: 1));
      yield count;
    }
  }

  // Stream<String> getLocationUpdate() async* {
  //   if(await checkLocationPermission()){
  //     Geolocator.getPositionStream(locationSettings: locationSettings).listen((event)  =>  position = event.toString());
  //     print(position);
  //     var location = await Geolocator.getCurrentPosition();
  //     yield '${location.latitude} ${location.longitude}';
  //   }else{
  //     yield 'Location Permission Denied';
  //   }
  // }

  // Future<bool> checkLocationPermission() async{
  //   var permission = await Geolocator.checkPermission();
  //   if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
  //     return true;
  //   }else{
  //     permission = await Geolocator.requestPermission();
  //     if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
  //       return true;
  //     }
  //     return false;
  //   }
  // }

  // CounterStream(){
  //   Geolocator.requestPermission().then((value) {
  //     if(value == LocationPermission.always || value == LocationPermission.whileInUse){
  //       final positionStream = geolocatorPlatform.getPositionStream(locationSettings: locationSettings);
  //       positionStreamSubscription = positionStream.listen((event) {
  //         print(event);
  //         streamController.add(event.toString());
  //       });
  //     }
  //   });
  // }

  // void cancelGeoLocatorSubscription(){
  //   if(positionStreamSubscription != null){
  //     positionStreamSubscription?.cancel();
  //   }
  // }
}
