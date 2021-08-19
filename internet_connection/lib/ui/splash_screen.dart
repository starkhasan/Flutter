import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection/provider/connectivity_provider.dart';
import 'package:internet_connection/ui/connectivity_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.indigo,
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: Center(child: Image.asset('assets/images/logo.png',width: 100,height: 100)),
                        ),
                        Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.65
                        )
                      ]
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.30, MediaQuery.of(context).size.width * 0.05, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [BoxShadow(color: Color(0xFF9FA8DA),blurRadius: 4.0)]
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).padding.top),
                            child: Column(
                              children: [
                                const Text('Sign Up'),
                                const TextField(
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Full Name'
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                    hintText: 'Mobile Number'
                                  )
                                ),
                                const SizedBox(height: 10),
                                const TextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Email'
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const TextField(
                                  obscureText: true,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                    hintText: 'Password'
                                  )
                                )
                              ]
                            )
                          ),
                          InkWell(
                            onTap: () => checkConnection(context),
                            child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.061,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                            ),
                            child: const Text('SIGN UP',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                          )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }

  checkConnection(BuildContext context) async{
    var result = await ConnectivityProvider().getConnection();
    if(result == ConnectivityResult.none){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectivityScreen()));
    }else{
      //Please don't forgot to perform validation on form before saving user data.
      var snackbar = const SnackBar(content: Text('Registration Successful',style: TextStyle(color: Colors.green)),duration: Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

}