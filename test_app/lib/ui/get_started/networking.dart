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
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)),boxShadow: [BoxShadow(blurRadius: 2.0,color: Colors.grey)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listUserResponse[index].name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      Text(listUserResponse[index].email,style: const TextStyle(color: Colors.grey)),
                      Text(listUserResponse[index].phone,style: const TextStyle(color: Colors.grey)),
                      Text(listUserResponse[index].webSite,style: const TextStyle(color: Colors.grey))
                    ]
                  )
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
                  color: const Color.fromARGB(255, 214, 214, 214),
                  child: const Text('Company',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listUserResponse[index].company.name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      Text('catchPhrase : ${listUserResponse[index].company.catchPhrase}',style: const TextStyle(color: Colors.black)),
                    ]
                  )
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
                  color: const Color.fromARGB(255, 214, 214, 214),
                  child: const Text('Address',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${listUserResponse[index].address.street}, ${listUserResponse[index].address.suite}, ${listUserResponse[index].address.city} ',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                      Text(listUserResponse[index].address.zipCode,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    ]
                  )
                )
              ]
            )
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