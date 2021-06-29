import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_flutter/ui/LoginUser.dart';
import 'package:hello_flutter/ui/MultiLanguages.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';
import 'package:hello_flutter/utils/Preferences.dart';
import 'package:hello_flutter/utils/LanguageSettings/locale_constant.dart';

class HomeDrawer extends StatefulWidget {
  final String title;
  HomeDrawer({this.title});
  @override
  State<StatefulWidget> createState() => _HomeDrawer();
}

class _HomeDrawer extends State<HomeDrawer> {
  List<String> listLanguage;
  var userName = "";
  var imagePath = '';
  var isDark = false;
  var googleImage = '';
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();
    Preferences.getName().then((value) => userName = value);
    Preferences.getGoogleImage().then((value) {
      setState(() {
        imagePath = '';
        googleImage = value;
      });
    });
    Preferences.getImagePath().then((value) {
      setState(() {
        imagePath = value;
      });
    });
    getDark().then((value) {
      setState(() {
        isDark = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    listLanguage = [
      Languages.of(context).language,
      Languages.of(context).logout,
      'Dark Mode'
    ];
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
                color: Colors.pink,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          userName,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ))
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
                  if(widget.title != 'Languages') Navigator.push(context,MaterialPageRoute(builder: (context) => MultiLanguages()));
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
                    listLanguage[index],
                    style: TextStyle(color: Colors.black),
                  ),
                  Expanded(
                      child: index == 3
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: isDark,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  changeDarkMode(context, value);
                                  setState(() {
                                    isDark = value;
                                  });
                                },
                              ))
                          : SizedBox())
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

  _logoutUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (googleImage != '') googleSignIn.signOut();
                  Preferences.setGoogleImage('');
                  Preferences.setImagePath("");
                  Preferences.setLogin(false);
                  Preferences.setName("");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginUser()),
                      (route) => false);
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No', style: TextStyle(color: Colors.white)),
              )
            ],
          );
        });
  }

  _logout() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Exit'),
            content: Text('Are you sure want to exit the app'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => print('Exit'),
                child: Text('No'),
              ),
              CupertinoDialogAction(
                onPressed: () => print('Not Exit'),
                child: Text('Yes'),
              )
            ],
          );
        });
  }
}
