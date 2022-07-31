import 'package:flutter/material.dart';
import 'package:flutter_animation/view/composed_page.dart';

class ContainerTransform extends StatelessWidget {
  const ContainerTransform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Container Transform')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, _navigate()),
          child: const Text('Go'),
        )
      )
    );
  }

  Route _navigate() => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ComposedPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation,child: child);
    }
  );
}
