import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_flutter/ui/CameraExample.dart';
import 'package:hello_flutter/ui/LoginUser.dart';
import 'package:hello_flutter/ui/MultiLanguages.dart';
import 'package:hello_flutter/ui/RegisterUser.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';
import 'package:hello_flutter/utils/Preferences.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeDrawer();
}

class _HomeDrawer extends State<HomeDrawer> {
  List<String> listLanguage;
  var userName = "";
  var imagePath;

  @override
  void initState() {
    super.initState();
    Preferences.getName().then((value) {
      setState(() {
        userName = value;
      });
    });
    Preferences.getImagePath().then((value) {
      setState(() {
        imagePath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    listLanguage = ['Language','Logout'];
    return Drawer(
      elevation: 15.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.blue,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () async {
                              final cameras = await availableCameras();
                              final camera = cameras.first;
                              var temp = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CameraExample(camera: camera)));
                              if (temp != null) {
                                setState(() {
                                  Preferences.setImagePath(temp);
                                  imagePath = temp;
                                });
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              child: imagePath == null
                                  ? Icon(Icons.camera_alt)
                                  : null,
                              backgroundImage: imagePath == null
                                  ? null
                                  : FileImage(File(imagePath)),
                            )),
                        SizedBox(width: 10),
                        Text(
                          userName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: _listViewBuilder(),
            )
          ],
        ),
      ),
    );
  }

  Widget _listViewBuilder() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: listLanguage.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          color: Colors.lightBlue[100],
          child: InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiLanguages()));
                  break;
                case 1:
                  _logoutUser();
                  break;
                default:
              }
            },
            child: Ink(
              color: Colors.black,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.language, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    index == 0
                        ? Languages.of(context).language
                        : listLanguage[index],
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  _logoutUser(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Logout'),
          content: Text(
            'Are you sure you want to logout?'
          ),
          actions: [
            FlatButton(
              onPressed: (){
                Preferences.setImagePath("");
                Preferences.setLogin(false);
                Preferences.setName("");
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginUser()), (route) => false);
              },
              child: Text('Yes'),
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('No',style: TextStyle(color: Colors.red)),
            )
          ],
        );
      }
    );
  }
}
