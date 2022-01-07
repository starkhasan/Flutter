import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/utils/preferences.dart';
import 'package:test_app/utils/helper.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with Helper{

  // String type = '';
  // String fcmTitle = '';
  // String fcmMessage = '';

  // static const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  // static const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  // static const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
  // static const InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //     macOS: initializationSettingsMacOS);


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   //this will call when app is not open, not even backgound(totally closed) 
  //   // FirebaseMessaging.instance
  //   //     .getInitialMessage()
  //   //     .then((RemoteMessage? message) {
  //   //   if (message != null){
  //   //     if(message.data['type'] == 'notification') {
  //   //       Navigator.push(context, MaterialPageRoute<void>(builder: (context) => NotificatonPage(title: message.notification!.title!,message: message.notification!.body!)));
  //   //     } else{
  //   //       Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage(title: message.notification!.title!,message: message.notification!.body!)));
  //   //     }
  //   //   }
  //   // });

  //   //this method will be called when app is in Foreground
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     setState((){
  //       type = message.data['type'];
  //       fcmMessage = message.notification!.body!;
  //       fcmTitle = message.notification!.title!;
  //     });
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             icon: '@mipmap/ic_launcher',
  //             importance: Importance.high
  //           ),
  //         )
  //       );
  //     }
  //   });

  //   //message.notification.title
  //   //message.notification.body

  //   //this methd will be called when app is in backgorund
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
  //     //print('A new onMessageOpenedApp event was published! $message');
  //     // var messageArguments = MessageArguments;
  //     // Navigator.pushNamed(context, '/message', arguments: messageArguments(message, true));
  //     if(message.data['type'] == 'notification') {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => NotificatonPage(title: message.notification!.title!,message: message.notification!.body!)));
  //     } else{
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage(title: message.notification!.title!,message: message.notification!.body!)));
  //     }
  //   });

  //   //it is usedful when we click the fcm when app in foreground state
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
  //   handleDynamicLink(context);
  // }

  // //this is used for handling Firebase dynamic link
  // void handleDynamicLink(BuildContext context) async {
  //   //get the initial dynamic link if the app is opened with a dynamic link
  //   final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

  //   //handle the link that has been reterived
  //   if (data != null) {
  //     //print('App is opened with dynamic link : deeplink $data');
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const FacebookPage()));
  //   }
    
  //   //Register a link callback if the app is opened from background using the dynamic link
  //   FirebaseDynamicLinks.instance.onLink(
  //     onSuccess: (PendingDynamicLinkData? dynamicLink) async {
  //       if (dynamicLink != null) {
  //         //print('App is opened from background using dynamic link : deeplink $dynamicLink');
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => const FacebookPage()));
  //       }
  //     }, 
  //     onError: (OnLinkErrorException e) async {
  //       //print('LinkErro ${e.message}');
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const TwitterPage()));
  //     }
  //   );
  // }

  // void selectNotification(String? payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   if(type == 'notification') {
  //     await Navigator.push(context, MaterialPageRoute<void>(builder: (context) => NotificatonPage(title: fcmTitle,message: fcmMessage)));
  //   } else{
  //     await Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage(title: fcmTitle,message: fcmMessage)));
  //   }
  // }


  // Future<void> sendPushNotification() async{
  //   //var token = await FirebaseMessaging.instance.getToken();
  //   //print(token);
  // }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    Preferences.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates Design'),
        centerTitle: true,
        backgroundColor: Colors.blue
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.send)
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: Helper.screenNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => landingPageNavigation(context,index),
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
              margin: const EdgeInsets.only(top: 5, left: 10, right: 10,bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.grey,blurRadius: 1.0)]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Helper.screenNames[index], style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                  SizedBox(width: 25,height: 25, child: index >= Helper.screenAssets.length ? null : Image.asset(Helper.screenAssets[index]))
                ]
              )
            )
          );
        }
      )
    );
  }
}
