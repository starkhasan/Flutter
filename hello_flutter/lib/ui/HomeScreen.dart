import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/AppLifeCycle.dart';
import 'package:hello_flutter/ui/CardSwipeScreen.dart';
import 'package:hello_flutter/ui/ExpandableCardList.dart';
import 'package:hello_flutter/ui/LandingPage.dart';
import 'package:hello_flutter/ui/PaymentScreen.dart';
import 'package:hello_flutter/ui/SwipeDeleteScreen.dart';
import 'package:hello_flutter/ui/SilverScreen.dart';
import 'package:hello_flutter/ui/CameraExample.dart';
import 'package:hello_flutter/utils/HomeDrawer.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<String> itemsList;
  var imagePath;
  @override
  Widget build(BuildContext context) {
    itemsList = [
      Languages.of(context).landingTitle,
      Languages.of(context).swipeTitle,
      Languages.of(context).expandableTitle,
      Languages.of(context).cardTitle,
      Languages.of(context).sliverScreen,
      Languages.of(context).appLifeCycle,
      'Payments',
      'Take Picture'
    ];
    return Scaffold(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LandingPage()));
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
    );
  }

  _getImagePath() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    var temp = await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraExample(camera:camera)));
    if (temp != null) {
      setState(() {
        imagePath = temp;
      });
    }
  }
}
