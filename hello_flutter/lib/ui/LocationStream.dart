import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/network/response/UserLocation.dart';
import 'package:hello_flutter/service/ConnectivityService.dart';
import 'package:hello_flutter/service/LocationService.dart';
import 'package:provider/provider.dart';

class LocationStream extends StatelessWidget {
  var _userLocation = UserLocation();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>(
      create: (context) => ConnectivityService().connectionStream,
      initialData: ConnectivityResult.none,
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<ConnectivityResult>(context);
    return Container(
      child: Center(
        child: Text('${userLocation}'),
      ),
    );
  }
}
