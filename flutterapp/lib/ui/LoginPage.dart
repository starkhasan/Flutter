
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/constant/Cv.dart';
import 'package:flutterapp/network/ApiCalling.dart';
import 'package:flutterapp/ui/PlayBack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {

  savedate() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Cv.ISLOGIN,true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        title: Text('First Route'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayBack()));
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: ApiService.login(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Card(
                      child : ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/interval.png')
                        ),
                        onTap: (){
                          Toast.show("$index CLicked", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                        },
                        title: Text(snapshot.data[index]['id'].toString()),
                        subtitle: Text(snapshot.data[index]['title'],maxLines: 1)
                      ),
                    );
                  },
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
        ),
      ),
    );
  }
}