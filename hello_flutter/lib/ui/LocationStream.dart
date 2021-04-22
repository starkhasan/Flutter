import 'package:flutter/material.dart';
import 'package:hello_flutter/network/response/UserLocation.dart';
import 'package:hello_flutter/service/LocationService.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationStream extends StatelessWidget {

  var _userLocation = UserLocation();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      initialData: _userLocation,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Location'),
        ),
        body: HomePage(),
      ),
    );
  }
}


class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Container(
      child: Center(
        child: Text('Your Location ${userLocation.latitude}, ${userLocation.lonitude}'),
      ),
    );
  }

}