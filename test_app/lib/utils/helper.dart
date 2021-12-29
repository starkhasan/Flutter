import 'package:flutter/material.dart';
import 'package:test_app/ui/deeplink/platform_integration_page.dart';
import 'package:test_app/ui/facebook_page.dart';
import 'package:test_app/ui/crypto_page.dart';
import 'package:test_app/ui/grocery/main_screen.dart';
import 'package:test_app/ui/keys_example/scroll_position_example.dart';
import 'package:test_app/ui/keys_example/widget_element_keys.dart';
import 'package:test_app/ui/payment_gateway/razorpay_payment.dart';
import 'package:test_app/ui/rest_api.dart';
import 'package:test_app/ui/tictactoa_screen.dart';
import 'package:test_app/ui/twitter_page.dart';
import 'package:test_app/ui/video_play_screen.dart';
import 'package:test_app/ui/web_socket.dart';
import 'package:test_app/ui/whatsapp_page.dart';
import 'package:test_app/ui/webview_page.dart';
import 'package:test_app/ui/sliverwidget_page.dart';
import 'package:test_app/ui/firebase_authentication.dart';

class Helper {
  
  void showSnackbar(BuildContext context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static List<String> listImageURL = [
    'https://m.media-amazon.com/images/I/91pDdDLHquL._SX522_.jpg',
    'https://www.bigbasket.com/media/uploads/p/xxl/40198145_1-popular-essentials-premium-jeera-rice.jpg',
    'https://m.media-amazon.com/images/I/71LpBnx+5xL._SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71bSLxCaGGL._SL1500_.jpg',
    'https://www.jiomart.com/images/product/original/490001392/amul-butter-500-g-carton-6-20210315.jpg',
    'https://www.bigbasket.com/media/uploads/p/l/104823_3-amul-cheese-spread-yummy-plain.jpg',
    'https://5.imimg.com/data5/PF/FT/XN/SELLER-6800096/amul-gold-milk-500ml-500x500.jpg',
    'https://m.media-amazon.com/images/I/615etm93zBL._SX522_.jpg',
    'https://m.media-amazon.com/images/I/519YSKro-XL.jpg',
    'https://m.media-amazon.com/images/I/61L0w87gCML._SX522_.jpg',
  ];

  static List<String> listProductName = [
    'Flour',
    'Rice',
    'Sugar',
    'Salt',
    'Butter',
    'Cheese',
    'Milk',
    'Red Chilli Powder',
    'Turmeric Powder',
    'Coriander Powder' 
  ];

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
    'Web Socket',
    'Widget Element Keys',
    'Scroll Position',
    'Video Player',
    'Grocery Plus'
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FacebookPage()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TwitterPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WhatsAppPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Crypto()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WebViewPage()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SliverWidgetPage()));
        break;
      case 6:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const FirebaseAuthentication()));
        break;
      case 7:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const RazorpayPaymentGateway()));
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
        Navigator.push(context,MaterialPageRoute(builder: (context) => const RestAPI()));
        break;
      case 10:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const WebSocket()));
        break;
      case 11:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const WidgetElementKeys()));
        break;
      case 12:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const ScrollPositionExample()));
        break;
      case 13:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const VideoPlayScreen()));
        break;
      case 14:
        Navigator.push(context,MaterialPageRoute(builder: (context) => const MainScreen()));
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