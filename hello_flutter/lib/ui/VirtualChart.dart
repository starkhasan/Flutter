import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/VirtualChatting.dart';

class VirtualChart extends StatefulWidget {
  @override
  _VirtualChartState createState() => _VirtualChartState();
}

class _VirtualChartState extends State<VirtualChart> {
  var databaseReference;

  @override
  void initState() {
    Firebase.initializeApp();
    databaseReference = FirebaseDatabase.instance.reference().child('users');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Virtual Chat'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VirtualChatting())),
        child: Icon(Icons.message),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () => insertData(), child: Text('Create')))
          ],
        ),
      ),
    );
  }

  void insertData() {
    databaseReference.child("shahid").set({
      'password': '1234'
    });
  }
}
