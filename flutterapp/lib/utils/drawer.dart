import 'package:flutter/material.dart';
import 'package:flutterapp/ui/AddPets.dart';
import 'package:flutterapp/ui/MapView.dart';
import 'package:flutterapp/ui/NaturallyLogin.dart';
import 'package:flutterapp/ui/Pets.dart';
import 'package:flutterapp/ui/Profile.dart';
import 'package:flutterapp/ui/Settings.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:toast/toast.dart';

class DrawerLayout extends StatefulWidget {

  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {

  GlobalKey _drawerKey = GlobalKey();

  _clearPreferences(){
    Preferences.addUserId(0);
    Preferences.addToken("");
    Preferences.addName("");
    Preferences.addEmail("");
    Preferences.addPhone("");
    Preferences.addPassword("");
    Preferences.setLogin(false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _drawerKey,
      elevation: 10.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.white,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Image.asset('assets/images/follohlogo.jpg')
                    )
                  )
                ]
              ),
            ),
            Container(
              color: Colors.white,
              child:ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MapView()));
                }
              )
            ),
            Container(
              color: Colors.white,
              child:ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  'My Profile',
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                }
              )
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading:Icon(
                  Icons.pets,
                  color: Colors.black,
                ),
                title: Text(
                  'My Pets',
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                ),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Pets()));
                }
              ) 
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.pets,
                  color: Colors.black,
                ),
                title: Text(
                  'Add Pets',
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddPets()));
                }
              )
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                ),
                onTap: () => Toast.show('Clicked',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM)
              )
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.subtitles,
                  color: Colors.black,
                ),
                title: Text(
                  'Terms and Conditions',
                  style: TextStyle(color: Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0)
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                }
              )
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  color: Color(int.parse("#144473".replaceAll("#", "0xff"))),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  onPressed: (){
                    _clearPreferences();
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>NaturallyLogin()));
                    Toast.show('Successfully Logout', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white,fontFamily: 'MontserratSemiBold',fontSize: 18.0),
                  ),
                )
              ),
            )
          ],
        ),
    );
  }
}