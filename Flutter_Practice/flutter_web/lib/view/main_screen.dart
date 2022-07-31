import 'package:flutter/material.dart';
import 'package:flutter_web/constants/strings.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth < 600){
          ///Mobile Application UI
          return Scaffold(
            body: Container(
              child: const Center(child: Text('Add Mobile UI Here'))
            ),
          );
        } else if(constraints.maxWidth < 912){
          ///Tablet Application UI
          var appBarPadding = Get.size.height * 0.02;
          return Scaffold(
            body: Column(
              children: [
                Container(
                  color: Colors.blue[100],
                  padding: EdgeInsets.only(top: appBarPadding, bottom: appBarPadding, left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          FlutterLogo(size: 28),
                          SizedBox(width: 5),
                          Text(Strings.artical, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => print('Click Here to Navigate the Home'),
                            child: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () => print('Click Here to Navigate the Home'),
                            child: const Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          )
                        ],
                      )
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 15),
                            Text('What is Flutter?',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                            SizedBox(height: 8),
                            Text(Strings.whatisFlutter),
                            SizedBox(height: 8),
                            Text('Who is Flutter for?',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                            SizedBox(height: 8),
                            Text(Strings.whoisFlutterFor)
                          ],
                        )
                      )
                    ]
                  )
                )
              ],
            ),
          );
        } else {
          ///Desktop Application UI
          var paddingGap = Get.size.width * 0.16;
          var appBarPadding = Get.size.height * 0.02;
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: [
                Container(
                  color: Colors.blue[100],
                  padding: EdgeInsets.only(left: paddingGap, right: paddingGap, top: appBarPadding, bottom: appBarPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          FlutterLogo(size: 28),
                          SizedBox(width: 5),
                          Text(Strings.artical, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => print('Click Here to Navigate the Home'),
                            child: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () => print('Click Here to Navigate the Home'),
                            child: const Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          )
                        ],
                      )
                    ]
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: paddingGap, right: paddingGap),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 15),
                            Text('What is Flutter?',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                            SizedBox(height: 8),
                            Text(Strings.whatisFlutter),
                             SizedBox(height: 8),
                            Text('Who is Flutter for?',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                            SizedBox(height: 8),
                            Text(Strings.whoisFlutterFor)
                          ],
                        )
                      )
                    ]
                  ),
                )
              ],
            ),
          );
        }
      } 
    );
  }
}
