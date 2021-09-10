import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Landing Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Click FAB'),
        child: const Icon(Icons.camera),
      ),
      body: const Center(child: Text('Landing Page')),
    );
  }
}
