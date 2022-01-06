import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/networks/response/user_response.dart';
import 'dart:convert';

class Networking extends StatefulWidget {
  const Networking({ Key? key }) : super(key: key);

  @override
  _NetworkingState createState() => _NetworkingState();
}

class _NetworkingState extends State<Networking> {

  List<UserResponse> listUserResponse = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Networking')),
      body: listUserResponse.isEmpty
      ? const Center(child: Text('Tap fab for Network call'))
      : ListView.builder(
        itemCount: listUserResponse.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Container(
            padding: const EdgeInsets.all(10),
            child: Text(listUserResponse[index].name),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getUserInformation(context),
        child: const Icon(Icons.download)
      )
    );
  }

  getUserInformation(BuildContext context) async{
    try {
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if(response.statusCode == 200){
        setState(() {
          listUserResponse = List<UserResponse>.from(jsonDecode(response.body).map((item) => UserResponse.fromJson(item)));
        });
      }
    } catch (e) {
      print('failed to call $e');
    }
  }
}