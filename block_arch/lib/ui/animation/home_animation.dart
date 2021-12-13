import 'package:block_arch/ui/animation/bounce_ball_explicit.dart';
import 'package:block_arch/ui/animation/bounce_ball_implicit.dart';
import 'package:block_arch/ui/animation/custom_painting.dart';
import 'package:block_arch/ui/animation/fade_animation.dart';
import 'package:block_arch/ui/animation/shape_effect.dart';
import 'package:block_arch/ui/animation/tween_animation.dart';
import 'package:block_arch/ui/animation/tween_explicit.dart';
import 'package:flutter/material.dart';

class HomeAnimation extends StatelessWidget {
  const HomeAnimation({ Key? key }) : super(key: key);

  final List<String> _listScreen = const [
    'Opacity Effect Implicit',
    'Shape Shifting Implicit',
    'Tween Animation Implicit',
    'BounceBall Implicit',
    'BounceBall Explicit',
    'Tween Explicit',
    'Custom Painter'
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Animation'),
      ),
      body: ListView.builder(
        itemCount: _listScreen.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: () {
              switch (index) {
                case 0:
                  navigateScreen(context, const FadeAnimation());
                  break;
                case 1:
                  navigateScreen(context, const ShapeEffect());
                  break;
                case 2:
                  navigateScreen(context, const TweenAnimationExample());
                  break;
                case 3:
                  navigateScreen(context, const BounceBallImplicit());
                  break;
                case 4:
                  navigateScreen(context, const BounceBallExplicit());
                  break;
                case 5:
                  navigateScreen(context, const TweenExplicit());
                  break;
                case 6:
                  navigateScreen(context, const CustomPainting());
                  break;
                default:
              }
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 2.0)]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_listScreen[index]),
                  const Icon(Icons.arrow_forward_ios)
                ]
              )
            )
          );
        }
      )
    );
  }

  navigateScreen(BuildContext context,Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}