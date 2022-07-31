import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  UserDetailsState createState() => UserDetailsState();
}

class UserDetailsState extends State<UserDetails> {

  var args = <dynamic, dynamic>{};

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { 
      args = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('User Details')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name : ${args['name']}'),
            Text('Age : ${args['age']}'),
            Text('DOB : ${args['dob']}'),
            Text('Email : ${args['email']}'),
            Text('Mobile : ${args['mobile']}'),
            Text('Father Name : ${args['father']}'),
            Text('Mother Name : ${args['mother']}'),
            Text('Address : ${args['address']}')
          ],
        ),
      ),
    );
  }
}
