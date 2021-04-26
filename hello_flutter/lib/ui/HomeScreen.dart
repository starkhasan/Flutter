import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_flutter/ui/AppLifeCycle.dart';
import 'package:hello_flutter/ui/CardSwipeScreen.dart';
import 'package:hello_flutter/ui/CounterScreen.dart';
import 'package:hello_flutter/ui/ExpandableCardList.dart';
import 'package:hello_flutter/ui/FutureBuilderScreen.dart';
import 'package:hello_flutter/ui/GoogleMapRoute.dart';
import 'package:hello_flutter/ui/LandingPage.dart';
import 'package:hello_flutter/ui/LocationStream.dart';
import 'package:hello_flutter/ui/PageViewScreen.dart';
import 'package:hello_flutter/ui/PaymentScreen.dart';
import 'package:hello_flutter/ui/PhotoFile.dart';
import 'package:hello_flutter/ui/PieChart.dart';
import 'package:hello_flutter/ui/ScrollAnimation.dart';
import 'package:hello_flutter/ui/Scroller.dart';
import 'package:hello_flutter/ui/SwipeDeleteScreen.dart';
import 'package:hello_flutter/ui/NotificationScreen.dart';
import 'package:hello_flutter/ui/SilverScreen.dart';
import 'package:hello_flutter/ui/CameraExample.dart';
import 'package:hello_flutter/ui/TransformUI.dart';
import 'package:hello_flutter/ui/WidgetDemo.dart';
import 'package:hello_flutter/ui/DownloadFile.dart';
import 'package:hello_flutter/ui/YouTubeFlutter.dart';
import 'package:hello_flutter/utils/HomeDrawer.dart';
import 'package:hello_flutter/ui/CupertinoScreen.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<String> itemsList;
  var imagePath;
  Position _initialPositon;

  static const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  static const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  static const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //When the application is the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A  onMessageOpenedApp event was published! when in background');
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
    });
    //When Application is Terminated
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      print('A  getInitialMessage() published! when is closed');
      if (message != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
      }
    });
    //when the application is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: 'launch_background',
            ),
          )
        );
      }
    });
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => NotificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    itemsList = [
      Languages.of(context).landingTitle,
      Languages.of(context).swipeTitle,
      Languages.of(context).expandableTitle,
      Languages.of(context).cardTitle,
      Languages.of(context).sliverScreen,
      Languages.of(context).appLifeCycle,
      Languages.of(context).payment,
      Languages.of(context).takePicture,
      Languages.of(context).notification,
      Languages.of(context).photoFile,
      Languages.of(context).scroller,
      Languages.of(context).pieChart,
      Languages.of(context).pageView,
      Languages.of(context).googleMap,
      Languages.of(context).cupertinoStyle,
      'Future Builder',
      'Transform UI',
      'Download File',
      'Widget Demo',
      'CheckboxListTile',
      'Scroll Animation',
      'YouTube Flutter',
      'Location'
    ];
    return WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          drawer: HomeDrawer(title: 'Home'),
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text(Languages.of(context).homeTitle),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => print('Tap on Add Check'),
                icon: Icon(Icons.library_add_check, color: Colors.white),
              ),
              IconButton(
                onPressed: () => print('Tap on Cart'),
                icon: Icon(Icons.shopping_cart, color: Colors.white),
              )
            ],
          ),
          body: Container(
            child: ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Card(
                    child: InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
                        break;
                      case 1:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SwipeDeleteScreen()));
                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpandableCardList()));
                        break;
                      case 3:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardSwipeScreen()));
                        break;
                      case 4:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SilverScreen()));
                        break;
                      case 5:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppLifeCycle()));
                        break;
                      case 6:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()));
                        break;
                      case 7:
                        _getImagePath();
                        break;
                      case 8:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                        break;
                      case 9:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhotoFile()));
                        break;
                      case 10:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scroller()));
                        break;
                      case 11:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PieChartSample()));
                        break;
                      case 12:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageViewScreen()));
                        break;
                      case 13:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoogleMapRoute(
                                    initialPostion: _initialPositon)));
                        break;
                      case 14:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CupertinoScreen()));
                        break;
                      case 15:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FutureBuilderScreen()));
                        break;
                      case 16:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransformUI()));
                        break;
                      case 17:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DownloadFile()));
                        break;
                      case 18:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetDemo()));
                        break;
                      case 19:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CounterScreen()));
                        break;
                      case 20:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScrollAnimation()));
                        break;
                      case 21:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YouTubeFlutter()));
                        break;
                      case 22:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationStream()));
                        break;
                      default:
                    }
                  },
                  child: ListTile(
                    title: Text(itemsList[index]),
                    trailing: imagePath != null
                        ? Image.file(File(imagePath))
                        : Icon(Icons.cloud_upload),
                  ),
                ));
              },
            ),
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>  AlertDialog(
            title:  Text('Exit'),
            content:  Text('Do you want to exit an App'),
            actions: <Widget>[
               ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child:  Text('No', style: TextStyle(color: Colors.red)),
              ),
               ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:  Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  _getImagePath() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    var temp = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CameraExample(camera: camera)));
    if (temp != null) {
      setState(() {
        imagePath = temp;
      });
    }
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        _initialPositon = value;
      });
    });
  }
}
