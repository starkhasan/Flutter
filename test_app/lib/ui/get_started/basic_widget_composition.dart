import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
class BasicWidgetComposition extends StatefulWidget {
  const BasicWidgetComposition({ Key? key }) : super(key: key);

  @override
  _BasicWidgetCompositionState createState() => _BasicWidgetCompositionState();
}

class _BasicWidgetCompositionState extends State<BasicWidgetComposition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Widget')),
      body: ListView(
        children: const [
          DesignFirst(),
          DesignSecond(),
          DesignThird()
        ]
      )
    );
  }
}

class DesignFirst extends StatelessWidget {
  const DesignFirst({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Flutter McFlutter'),
                    Text('Experience App Developer')
                  ]
                )
              ]
            )
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('123 Main Street'),
              Text('(415) 555-0198')
            ]
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.favorite),
              Icon(Icons.cloud),
              Icon(Icons.mobile_off_outlined),
              Icon(Icons.phone_android_outlined)
            ]
          ),
          const SizedBox(height: 5),
        ]
      )
    );
  }
}

class DesignThird extends StatefulWidget {
  const DesignThird({ Key? key }) : super(key: key);

  @override
  _DesignThirdState createState() => _DesignThirdState();
}

class _DesignThirdState extends State<DesignThird> {

  late Timer timer;

  startTimer(){
    timer = Timer.periodic(const Duration(seconds: 2), (timer) => setState(() {}));
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: MediaQuery.of(context).size.height * 0.30,
      child: Stack(
        children: List.generate(12, (index) {
          return Positioned(
            child: GestureDetector(
              onTap: () => setState(() {}),
              child: AnimatedAlign(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 500),
                alignment: Alignment(math.Random().nextDouble() * 2 - 1,math.Random().nextDouble() * 2 - 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: math.Random().nextDouble() * 40 + 10,
                  width: math.Random().nextDouble() * 40 + 10,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.primaries[math.Random().nextInt(Colors.primaries.length)],shape: BoxShape.circle)
                  )
                )
              )
            )
          );
        })
      )
    );
  }

}




class DesignSecond extends StatelessWidget {
  const DesignSecond({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
      decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)),boxShadow: [BoxShadow(spreadRadius: 1.0,blurRadius: 2.0,color: Colors.grey)]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            child: Image.network('https://raw.githubusercontent.com/libgit2/libgit2sharp/master/square-logo.png',fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Oeschinen Lake Campgroung'),
                      Text('Kandersteg, Switzerland')
                    ]
                  ),
                ),
                const Icon(Icons.star,color: Colors.red),
                const Text('41')
              ]
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => showSnackbar(context, 'CALL'),
                child: Column(children: const [Icon(Icons.call,color: Colors.blue,size: 20),Text('CALL',style: TextStyle(color: Colors.blue,fontSize: 12))])),
              GestureDetector(
                onTap: () => showSnackbar(context, 'SHARE'),
                child: Column(children: const [Icon(Icons.share,color: Colors.blue,size: 20),Text('SHARE',style: TextStyle(color: Colors.blue,fontSize: 12))])),
              GestureDetector(
                onTap: () => showSnackbar(context, 'ROUTE'),
                child: Column(children: const [Icon(Icons.navigation,color: Colors.blue,size: 20),Text('ROUTE',style: TextStyle(color: Colors.blue,fontSize: 12))])) 
            ]
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
              'Alps. Situated 1,578 meters above sea level, it is one of the '
              'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
              'half-hour walk through pastures and pine forest, leads you to the '
              'lake, which warms to 20 degrees Celsius in the summer. Activities '
              'enjoyed here include rowing, and riding the summer toboggan run.',
              softWrap: true
            )
          )
        ]
      )
    );
  }

  void showSnackbar(BuildContext _context,String message){
    var snackbar = SnackBar(duration : const Duration(seconds: 1),content: Text('Click on $message'));
    ScaffoldMessenger.of(_context).showSnackBar(snackbar);
  }
}