import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/providers/LoginProvider.dart';
import 'package:hello_flutter/ui/RegisterUser.dart';
import 'package:provider/provider.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Login User',style: TextStyle(fontWeight: FontWeight.normal)),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterUser())), 
                icon: Icon(Icons.person_add)
              )
            ],
          ),
          body: ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider(),
            child: Consumer<LoginProvider>(
              builder: (context,loginProvider,child){
                return Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                      children: <Widget>[
                        TextField(
                          maxLines: 1,
                          controller: _controllerEmail,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: 'Email'),
                          onChanged: (value) => loginProvider.checkLoginField(_controllerEmail.text.toString(), _controllerPassword.text.toString()),
                        ),
                        SizedBox(height: 5),
                        TextField(  
                          obscureText: loginProvider.isPasswordVisible ? false : true,
                          showCursor: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          controller: _controllerPassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () => loginProvider.passwordVisible(),
                              icon: loginProvider.isPasswordVisible ? Icon(Icons.lock) : Icon(Icons.lock_open_rounded),
                            )
                          ),
                          onSubmitted: (value) => loginProvider.loginUser(context,_controllerEmail.text,_controllerPassword.text),
                          onChanged: (value) => loginProvider.checkLoginField(_controllerEmail.text.toString(), _controllerPassword.text.toString()),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: loginProvider.isFilled ? () => loginProvider.loginUser(context,_controllerEmail.text,_controllerPassword.text) : null,
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10)
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Or',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () => loginProvider.googleLogin(context),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 2.0)]
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                loginProvider.isGoogleSignIn
                                  ? Image.asset('assets/images/googlebutton.png',height: 25,width: 25)
                                  : SizedBox(width: 20,height: 20,child: CircularProgressIndicator(strokeWidth: 2)),
                                SizedBox(width: 10),
                                Text(
                                  'Sign in with Google',
                                  style: TextStyle(color: Colors.grey,fontSize: 16)
                                )
                              ],
                            ),
                          )
                        )
                      ]
                    )
                  )
                );
              },
            )
          )
      );
  }

  // void _verifyPhoneAuth(String phone) async{
  //   await Firebase.initializeApp();
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '+91 '+phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async{
  //       await auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseException e){
  //       Helper.showToast(e.message  ,Colors.red);
  //     },
  //     codeSent: (String verificationId, int resendToken) async{
  //       Preferences.setName(_controllerPhone.text);
  //       String smsCode = '564781';
  //       PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //       var user = await auth.signInWithCredential(phoneAuthCredential);
  //       Helper.showToast('User Signned in Successfully with $verificationId'  ,Colors.red);
  //       Preferences.setLogin(true);
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomeScreen()),
  //           (route) => false);
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId){
  //     }
  //   );
  // }
}
