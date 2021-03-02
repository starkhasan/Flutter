import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/network/Api.dart';
import 'dart:convert';
import 'package:hello_flutter/network/response/UserResponse.dart';

class FutureBuilderScreen extends StatefulWidget {
  @override
  _FutureBuilderScreenState createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Future Builder')
      ),
      body: FutureBuilder(
        future: fetchUser(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data == '400' || snapshot.data == '500'){
              return Container(
                child: Center(
                  child: Text('Something went wrong')
                )
              );
            }else{
              var data  = List<UserResponse>.from(json.decode(snapshot.data).map((x) => UserResponse.fromJson(x)));
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    shadowColor: Colors.grey[100],
                    color: Colors.white,
                    child: ListTile(
                      title: Text(data[index].title)
                    )
                  );
                }
              );
            }
          }else{
            return Container(
              child: Center(
                child: Text('Loading...')
              )
            );
          }
        }
      )
    );
  }

  fetchUser() async{
    return Api.getUser();
  }
}