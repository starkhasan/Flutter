import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformIntegrationPage extends StatefulWidget {
  const PlatformIntegrationPage({ Key? key }) : super(key: key);

  @override
  _PlatformIntegrationPageState createState() => _PlatformIntegrationPageState();
}

class _PlatformIntegrationPageState extends State<PlatformIntegrationPage> {

  static const platformMethodChannel = MethodChannel('com.example.test_app/battery_level');
  static const platformEventChannel = EventChannel('com.example.test_app/location_service');
  String battery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Deep Link'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Battery Level : $battery'),
            ElevatedButton(
              onPressed: getBatteryLevelClient,
              child: const Text('Battery Level')
            ),
            const Text('User Location : '),
            ElevatedButton(
              onPressed: getStreamLocation,
              child: const Text('Tap once to get continuous Location')
            )
          ]
        )
      )
    );
  }

  Future<void> getBatteryLevelClient() async{
    String batteryLevel = '';
    try {
      var result = await platformMethodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery Level $result %';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get Battery Level ${e.message}';
    }
    setState(() {
      battery = batteryLevel;
    });
  }

  Future<void> getStreamLocation() async{
    try {
      platformEventChannel.receiveBroadcastStream().listen((event) { 
        print(event);
      });
    } catch (e) {
      print("Couldn't receive the event");
    }
  }
}