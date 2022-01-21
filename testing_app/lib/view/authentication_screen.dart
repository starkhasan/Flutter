import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:testing_app/model/UserResponse.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({ Key? key }) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var padding = 0.0;

  @override
  void didChangeDependencies() {
    padding = MediaQuery.of(context).size.width *0.05;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Authentication')),
      body: Container(
        padding: EdgeInsets.all(padding),
        color: Colors.white,
        child: Column(
          children: [
            TextField(
              key: const Key('EmailKey'),
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email',label: Text('Enter Email'),enabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              key: const Key('PasswordKey'),
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              key: const Key('ButtonKey'),
              onPressed: () => setState(() => emailController.text = 'Abdul Shahid'), 
              child: const Text('Continue')
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => readLocalAssets(),
        child: const Icon(Icons.download),
      ),
    );
  }


  Future<void> readLocalAssets() async{
    var file = await DefaultAssetBundle.of(context).loadString('assets/localJson/defaultUserInformation.json');
    var response = List<UserResponse>.from(jsonDecode(file).map((item) => UserResponse.fromJson(item)));
    response.forEach((element) { 
      print(element.name);
    });
  }

  authentication(BuildContext context){
    if(validation(context)){
      showSnackbar(context, 'User Login Successfully');
    }
  }

  bool validation(BuildContext context){
    if(emailController.text.isEmpty){
      showSnackbar(context, 'Please provide the email');
      return false;
    }else if(passwordController.text.isEmpty){
      showSnackbar(context, 'Please provide the password');
      return false;
    }else if(passwordController.text.length < 6){
      showSnackbar(context, 'Length of password should be atleast 6');
      return false;
    }else{
      return true;
    }
  }

  showSnackbar(BuildContext context, String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}