import 'package:flutter/material.dart';
import 'package:test_app/ui/crypto_page.dart';
import 'package:test_app/ui/facebook_page.dart';
import 'package:test_app/ui/sliverwidget_page.dart';
import 'package:test_app/ui/twitter_page.dart';
import 'package:test_app/ui/webview_page.dart';
import 'package:test_app/ui/whatsapp_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenNames = ['Facebook','Twitter','WhatsApp','Cypto','WebView','Sliver Widget'];
    var screenAssets = ['asset/facebook.png','asset/twitter.png','asset/whatsapp.png','asset/crypto.png'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates Design'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: screenNames.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: () => onClick(context, index),
            child: Container(
              padding: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
              margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(screenNames[index],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                  SizedBox(width: 25,height: 25,child: index >= screenAssets.length ? null : Image.asset(screenAssets[index]))
                ]
              )
            ),
          );
        }
      ),
    );
  }

  onClick(BuildContext _context,int index){
    switch (index) {
      case 0:
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const FacebookPage()));
        break;
      case 1:
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const TwitterPage()));
        break;
      case 2:
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const WhatsAppPage()));
        break;
      case 3:
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const Crypto()));
        break;
      case 4:
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const WebViewPage()));
        break;
      case 5:
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const SliverWidgetPage()));
        break;
      default:
    }
  }
}