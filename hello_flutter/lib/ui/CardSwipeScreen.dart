import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';


class CardSwipeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CardSwipeScreen();
}

class _CardSwipeScreen extends State<CardSwipeScreen>
    with TickerProviderStateMixin {
  List<String> listImages = [
    'assets/images/about_device.png',
    'assets/images/interval.png',
    'assets/images/monitoring.png',
    'assets/images/password.png',
    'assets/images/power_off.png',
    'assets/images/reboot.png',
    'assets/images/reset.png',
    'assets/images/signal_light.png',
    'assets/images/sos_list.png',
    'assets/images/sensor_light.png'
  ];
  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).cardTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: TinderSwapCard(
              swipeDown: true,
              swipeUp: true,
              totalNum: listImages.length,
              stackNum: 3,
              swipeEdge: 5.0,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              maxHeight: MediaQuery.of(context).size.width * 0.8,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              minHeight: MediaQuery.of(context).size.width * 0.7,
              cardBuilder: (context, index) {
                return Card(
                  child: Image.asset('${listImages[index]}'),
                );
              },
              cardController: controller = CardController(),
              swipeUpdateCallback: (DragUpdateDetails details,Alignment align){
                if(align.x < 0)
                  print('Left Swipe');
                else
                  print('Right Swipe');
              },
            )
          ),
      ),
    );
  }
}
