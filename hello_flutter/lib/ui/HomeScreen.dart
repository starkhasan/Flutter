import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_flutter/ui/AppLifeCycle.dart';
import 'package:hello_flutter/ui/CardSwipeScreen.dart';
import 'package:hello_flutter/ui/ExpandableCardList.dart';
import 'package:hello_flutter/ui/GoogleMapRoute.dart';
import 'package:hello_flutter/ui/LandingPage.dart';
import 'package:hello_flutter/ui/PageViewScreen.dart';
import 'package:hello_flutter/ui/PaymentScreen.dart';
import 'package:hello_flutter/ui/PhotoFile.dart';
import 'package:hello_flutter/ui/PieChart.dart';
import 'package:hello_flutter/ui/Scroller.dart';
import 'package:hello_flutter/ui/SwipeDeleteScreen.dart';
import 'package:hello_flutter/ui/NotificationScreen.dart';
import 'package:hello_flutter/ui/SilverScreen.dart';
import 'package:hello_flutter/ui/CameraExample.dart';
import 'package:hello_flutter/utils/HomeDrawer.dart';
import 'package:hello_flutter/ui/CupertinoScreen.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<String> itemsList;
  var imagePath;
  Position _initialPositon;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
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
      'Photo File',
      'Scroller',
      'Pie Chart',
      'Page View',
      'Google Map',
      'Cupertino Style'
    ];
    return WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          drawer: HomeDrawer(),
          appBar: AppBar(
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
                                builder: (context) => PieChart()));
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
          builder: (context) => new AlertDialog(
            title: new Text('Exit'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No', style: TextStyle(color: Colors.red)),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  _getImagePath() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    var temp = await Navigator.push(context,MaterialPageRoute(builder: (context) => CameraExample(camera: camera)));
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
