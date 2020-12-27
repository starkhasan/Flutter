import 'dart:io';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AudioPlayer audioPlayer = new AudioPlayer();
  String kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';

  List<Contact> contacts = [];

  void startServicePlatform() async {
    if (Platform.isAndroid) {
      try {
        var methodChannel = MethodChannel('startService_Channel');
        var data = await methodChannel.invokeMethod("startService");
        print('print your data ${data}');
      } on PlatformException {
        print('Failed to get Information');
      }
      // Event Channel Code
      var eventChannel = EventChannel('com.example.hello_flutter');
      eventChannel.receiveBroadcastStream().listen((event) async {
        print(event);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      getAllContacts();
    } else {
      _getContactPermission();
    }
  }

  Future<void> _getContactPermission() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
    } else {
      print('Not Granted');
    }
  }

  getAllContacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red, //                   <--- border color
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            25.0) //                 <--- border radius here
                        )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        print("Clicked");
                      },
                      child: Text(
                        "Hello Everyone this is Ali Hasan,",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    )),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => print("Clicked"),
                    )
                  ],
                )),
            SizedBox(height: 20),
            RaisedButton(
                color: Colors.blue,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text('Check Connection',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () async {
                  /*Helper.isConnected().then((intenet) {
                          if (intenet != null && intenet) {
                            /*AwesomeDialog(
                                context: context,
                                headerAnimationLoop: false,
                                dismissOnTouchOutside: false,
                                dialogType: DialogType.NO_HEADER,
                                title: 'Online',
                                btnOkText: 'OK',
                                desc:
                                    'Your connection has been established',
                                btnOkColor: Colors.green,
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                })
                              ..show();*/
  
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.SUCCES,
                                title: 'Online',
                                desc:
                                    'Your connection has been established',
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnOkText: 'OK',
                                onDissmissCallback: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                })
                              ..show();
                          } else {
                            /*AwesomeDialog(
                                context: context,
                                headerAnimationLoop: false,
                                dismissOnTouchOutside: false,
                                dialogType: DialogType.NO_HEADER,
                                title: 'Connection Failed',
                                btnOkText: 'Close',
                                desc:
                                    'Please check your connection status and try again',
                                btnOkColor: Colors.red,
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                })
                              ..show();*/
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.ERROR,
                                title: 'Connection Failed',
                                desc:
                                    'Please check your connection status and try again',
                                btnCancelOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnCancelText: 'Close',
                                onDissmissCallback: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                })
                              ..show();
                          }
                        }),*/
                  startServicePlatform();
                  //refreshContacts();
                  //getAllContacts();
                  //Workmanager.registerOneOffTask("1", "simpleTask");
                }),
            Container(
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text('Ali Hasan'),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
