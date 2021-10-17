import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_app/ui/crypto_page.dart';
import 'package:test_app/ui/facebook_page.dart';
import 'package:test_app/ui/firebase_authentication.dart';
import 'package:test_app/ui/payment_gateway/razorpay_payment.dart';
import 'package:test_app/ui/sliverwidget_page.dart';
import 'package:test_app/ui/payment_gateway/square_payment_page.dart';
import 'package:test_app/ui/twitter_page.dart';
import 'package:test_app/ui/webview_page.dart';
import 'package:test_app/ui/whatsapp_page.dart';
import 'package:test_app/utils/preferences.dart';
import 'package:test_app/ui/notification_page.dart';
import 'package:test_app/ui/offer_page.dart';

import '../main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  String type = '';
  String fcmTitle = '';
  String fcmMessage = '';

  static const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  static const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  static const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
  static const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //this will call when app is not open, not even backgound(totally closed) 
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage? message) {
    //   if (message != null){
    //     if(message.data['type'] == 'notification') {
    //       Navigator.push(context, MaterialPageRoute<void>(builder: (context) => NotificatonPage(title: message.notification!.title!,message: message.notification!.body!)));
    //     } else{
    //       Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage(title: message.notification!.title!,message: message.notification!.body!)));
    //     }
    //   }
    // });

    //this method will be called when app is in Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState((){
        type = message.data['type'];
        fcmMessage = message.notification!.body!;
        fcmTitle = message.notification!.title!;
      });
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/ic_launcher',
              importance: Importance.high
            ),
          )
        );
      }
    });

    //message.notification.title
    //message.notification.body


    //this methd will be called when app is in backgorund
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print('A new onMessageOpenedApp event was published! $message');
      // var messageArguments = MessageArguments;
      // Navigator.pushNamed(context, '/message', arguments: messageArguments(message, true));
      if(message.data['type'] == 'notification') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificatonPage(title: message.notification!.title!,message: message.notification!.body!)));
      } else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage(title: message.notification!.title!,message: message.notification!.body!)));
      }
    });

    //it is usedful when we click the fcm when app in foreground state
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
    
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    if(type == 'notification') {
      await Navigator.push(context, MaterialPageRoute<void>(builder: (context) => NotificatonPage(title: fcmTitle,message: fcmMessage)));
    } else{
      await Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage(title: fcmTitle,message: fcmMessage)));
    }
  }


  Future<void> sendPushNotification() async{
    var token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    Preferences.init();
    var screenNames = [
      'Facebook',
      'Twitter',
      'WhatsApp',
      'Cypto',
      'WebView',
      'Sliver Widget',
      'Firebase Services',
      'Square Payment'
    ];
    var screenAssets = [
      'asset/facebook.png',
      'asset/twitter.png',
      'asset/whatsapp.png',
      'asset/crypto.png'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates Design'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendPushNotification,
        child: const Icon(Icons.send)
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: screenNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onClick(context, index),
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 1.0)]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(screenNames[index], style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                  SizedBox(width: 25,height: 25, child: index >= screenAssets.length ? null : Image.asset(screenAssets[index]))
                ]
              )
            ),
          );
        }
      ),
    );
  }

  onClick(BuildContext _context, int index) {
    switch (index) {
      case 0:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const FacebookPage()));
        break;
      case 1:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const TwitterPage()));
        break;
      case 2:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const WhatsAppPage()));
        break;
      case 3:
        Navigator.push(
            _context, MaterialPageRoute(builder: (_context) => const Crypto()));
        break;
      case 4:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const WebViewPage()));
        break;
      case 5:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const SliverWidgetPage()));
        break;
      case 6:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const FirebaseAuthentication()));
        break;
      case 7:
        Navigator.push(_context,
            MaterialPageRoute(builder: (_context) => const RazorpayPaymentGateway()));
        break;
      default:
    }
  }
}
