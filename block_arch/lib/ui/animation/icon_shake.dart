import 'package:flutter/material.dart';
import 'dart:math';

class IconShake extends StatefulWidget {
  const IconShake({ Key? key }) : super(key: key);
  @override
  _IconShakeState createState() => _IconShakeState();
}

class _IconShakeState extends State<IconShake> {

  var selectedItem = 0;

  List<IconData> normalIcon = const [
    Icons.message,
    Icons.notifications,
    Icons.settings,
    Icons.share
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon Shake UI')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            color: Colors.grey[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => selectIcon(0),
                  icon: selectedItem == 0 ? TweenIcon(showIcon: normalIcon[0]) : Icon(normalIcon[0])
                ),
                IconButton(
                  onPressed: () => selectIcon(1),
                  icon: selectedItem == 1 ? TweenIcon(showIcon: normalIcon[1]) : Icon(normalIcon[1])
                ),
                IconButton(
                  onPressed: () => selectIcon(2),
                  icon: selectedItem == 2 ? TweenIcon(showIcon: normalIcon[2]) : Icon(normalIcon[2])
                ),
                IconButton(
                  onPressed: () => selectIcon(3),
                  icon: selectedItem == 3 ? TweenIcon(showIcon: normalIcon[3]) : Icon(normalIcon[3])
                )
              ]
            ),
          )
        ]
      )
    );
  }

  void selectIcon(int itemIndex) => setState(() => selectedItem = itemIndex);

}


class TweenIcon extends StatelessWidget{
  final IconData showIcon;
  const TweenIcon({Key? key,required this.showIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutBack,
      tween: Tween<double>(begin: 0.0,end: pi * 2),
      builder: (context, tweenValue, child){
        return Transform.rotate(
          angle: tweenValue,
          child: Icon(showIcon,size: 28.0,color: Colors.blue)
        );
      }
    );
  }
}

