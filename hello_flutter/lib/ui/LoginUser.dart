import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/providers/LoginProvider.dart';
import 'package:hello_flutter/ui/HomeScreen.dart';
import 'package:hello_flutter/ui/RegisterUser.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:hello_flutter/utils/Preferences.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerPhone = TextEditingController();
  GoogleSignInAccount _currentUser;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email','https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        //_handleGetContact(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }
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
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: false,
                          controller: _controllerPhone,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 10,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Enter your number',
                            hintStyle: TextStyle(
                              color: Colors.grey[400]
                            ),
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide()
                            )
                          ),
                          onFieldSubmitted: (value) {
                            value.length != 10
                              ? Helper.showToast('Please provide valid mobile number'  ,Colors.red)
                              : _verifyPhoneAuth(value);
                          },
                        ),
                        SizedBox(height: 20),
                        _buildbody()
                      ],
                    )
                  )
                );
              },
            )
          )
      );
  }

  Future<void> _handleSingIn() async{
    try{
      var user = await _googleSignIn.signIn();
      print(user);
    }catch(error){
      print(error);
    }
  }

  Widget _buildbody(){
    GoogleSignInAccount user = _currentUser;
    if(user != null){
      return Column(
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text("Signed in successfully."),
          Text('_contactText'),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: null,
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => null,
          ),
        ]
      );
    }else{
      return ElevatedButton(
        onPressed: _handleSingIn,
        child: Text('Login with Google'),
      );
    }
  }

  void _verifyPhoneAuth(String phone) async{
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: '+91 '+phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException e){
        Helper.showToast(e.message  ,Colors.red);
      },
      codeSent: (String verificationId, int resendToken) async{
        Preferences.setName(_controllerPhone.text);
        String smsCode = '564781';
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        var user = await auth.signInWithCredential(phoneAuthCredential);
        Helper.showToast('User Signned in Successfully with $verificationId'  ,Colors.red);
        Preferences.setLogin(true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      },
      codeAutoRetrievalTimeout: (String verificationId){
      }
    );
  }
}
