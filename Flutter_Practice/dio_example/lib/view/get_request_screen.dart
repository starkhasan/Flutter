import 'dart:math';
import 'package:dio_example/controller/get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetRequestScreen extends StatelessWidget {
  const GetRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final GetController getController = Get.put(GetController());
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Get Request')),
      body: GetBuilder<GetController>(
        init: GetController(),
        builder: (_) => ListView.builder(
          itemCount: _.listPost.length,
          itemBuilder: (context, index){
            return Container(height: 20,color: Colors.primaries[Random().nextInt(Colors.primaries.length)]);
          },
        ),
      )
    );
  }
}
