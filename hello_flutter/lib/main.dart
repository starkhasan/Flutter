import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/splash.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Spalsh()
    );
  }
}


/*
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String latitude = "waiting...";
  String longitude = "waiting...";
  String altitude = "waiting...";
  String accuracy = "waiting...";
  String bearing = "waiting...";
  String speed = "waiting...";
  String time = "waiting...";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Background Location Service'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              locationData("Latitude: " + latitude),
              locationData("Longitude: " + longitude),
              locationData("Altitude: " + altitude),
              locationData("Accuracy: " + accuracy),
              locationData("Bearing: " + bearing),
              locationData("Speed: " + speed),
              locationData("Time: " + time),
              RaisedButton(
                  onPressed: () {
                    _getPermission();
                  },
                  child: Text("Start Location Service")),
              RaisedButton(
                  onPressed: () {
                    BackgroundLocation.stopLocationService();
                  },
                  child: Text("Stop Location Service")),
              RaisedButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  child: Text("Get Current Location")),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  getCurrentLocation() {
    BackgroundLocation().getCurrentLocation().then((location) {
      print("This is current Location" + location.longitude.toString());
    });
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }

  _getPermission() {
    BackgroundLocation.getPermissions(
        onGranted: () {
          getBackgroundLocation();
        },
        onDenied: () {});
  }

  _checkLocation() {
    BackgroundLocation.checkPermissions().then((value) {});
  }

  Future<void> getBackgroundLocation() async {
    await BackgroundLocation.setNotificationTitle("Background service running");
    await BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) {
      setState(() {
        this.latitude = location.latitude.toString();
        this.longitude = location.longitude.toString();
        this.accuracy = location.accuracy.toString();
        this.altitude = location.altitude.toString();
        this.bearing = location.bearing.toString();
        this.speed = location.speed.toString();
        this.time = DateTime.fromMillisecondsSinceEpoch(location.time.toInt())
            .toString();
      });
      print("""\n
                        Latitude:  $latitude
                        Longitude: $longitude
                        Altitude: $altitude
                        Accuracy: $accuracy
                        Bearing:  $bearing
                        Speed: $speed
                        Time: $time
                      """);
    });
  }
}
*/

/*
var eventChannel = EventChannel('com.example.hello_flutter');
      eventChannel.receiveBroadcastStream().listen((event) {
        print(event);
      });
*/