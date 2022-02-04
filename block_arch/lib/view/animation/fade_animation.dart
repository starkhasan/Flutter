import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({ Key? key }) : super(key: key);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {

  double descriptionOpacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Animation')
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Image.asset('assets/earth.png'),
            TextButton(
              onPressed: () => setState(() => descriptionOpacity = 1.0),
              child: const Text('Show Details'),
            ),
            AnimatedOpacity(
              opacity: descriptionOpacity,
              duration: const Duration(seconds: 3),
              child: Column(
                children: const [
                  Text('Planet: Earth'),
                  Text('Age: 4.543 billion years'),
                  Text('Satellite: Moon'),
                  Text('Distance between Earth and Moon: 384,400 km'),
                  Text('Galaxy Name: Milky Way')
                ]
              )
            )
          ]
        )
      )
    );
  }
}