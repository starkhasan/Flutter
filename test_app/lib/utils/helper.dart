import 'package:flutter/material.dart';
import 'package:test_app/ui/deeplink/platform_integration_page.dart';
import 'package:test_app/ui/facebook_page.dart';
import 'package:test_app/ui/crypto_page.dart';
import 'package:test_app/ui/get_started/get_started_home.dart';
import 'package:test_app/ui/isolates_example.dart';
import 'package:test_app/ui/keys_example/scroll_position_example.dart';
import 'package:test_app/ui/keys_example/widget_element_keys.dart';
import 'package:test_app/ui/payment_gateway/razorpay_payment.dart';
import 'package:test_app/ui/responsive_user_interface.dart';
import 'package:test_app/ui/rest_api.dart';
import 'package:test_app/ui/twitter_page.dart';
import 'package:test_app/ui/video_play_screen.dart';
import 'package:test_app/ui/whatsapp_page.dart';
import 'package:test_app/ui/webview_page.dart';
import 'package:test_app/ui/sliverwidget_page.dart';
import 'package:test_app/ui/firebase_authentication.dart';

class Helper {
  
  void showSnackbar(BuildContext context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static var screenNames = [
    'Facebook',
    'Twitter',
    'WhatsApp',
    'Cypto',
    'WebView',
    'Sliver Widget',
    'Firebase Services',
    'Square Payment',
    'Deep Link',
    'Rest API',
    'Widget Element Keys',
    'Scroll Position',
    'Video Player',
    'Learning Isolates',
    'Get Started With Flutter',
    'Responsive UI'
  ];
  
  static var screenAssets = [
    'asset/facebook.png',
    'asset/twitter.png',
    'asset/whatsapp.png',
    'asset/crypto.png'
  ];

  void landingPageNavigation(BuildContext context,int index){
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FacebookPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TwitterPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WhatsAppPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Crypto()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewPage()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SliverWidgetPage()));
        break;
      case 6:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FirebaseAuthentication()));
        break;
      case 7:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RazorpayPaymentGateway()));
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const PlatformIntegrationPage();
            }
          )
        ).then((value) => {});
        break;
      case 9:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RestAPI()));
        break;
      case 10:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WidgetElementKeys()));
        break;
      case 11:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScrollPositionExample()));
        break;
      case 12:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlayScreen()));
        break;
      case 13:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const IsolateExample()));
        break;
      case 14:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GetStartedHome()));
        break;
      case 15:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ResponsiveUseInterface()));
        break;
      default:
    }
  }

  var groceryMoreItems = ['My Account','My Wishlist','Saved Addresses','All Orders','My Rewards'];

}

/**
 * Square
 * Sandbox Application ID
 * sandbox-sq0idb-SDo00t1mjESNdPC3dp1fXQ
 * Sandbox Access Token
 * EAAAELUlW3QKjLxy65AEG59yryCakHLl50uQSMOsovOHND84QbVa8P9XDHqW-fE0
 * Sandbox Location ID
 * LDWVWYVTV3AP7
 */