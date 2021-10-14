import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/service/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAuthentication extends StatefulWidget {
  const FirebaseAuthentication({ Key? key }) : super(key: key);

  @override
  _FirebaseAuthenticationState createState() => _FirebaseAuthenticationState();
}

class _FirebaseAuthenticationState extends State<FirebaseAuthentication> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firebaseReference = FirebaseDatabase.instance.reference().child('covid_info');
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthSevice().onAuthStateChange,
      builder: (BuildContext context, snapshot){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Authentication'),
          centerTitle: true
        ),
        body: Stack(
          children:[
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey)
                    )
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey)
                    )
                  ),
                  ElevatedButton(
                    onPressed: () => createUser(emailController.text,passwordController.text), 
                    child: const Text('Register')
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => snapshot.data != null ? userSignOut() : userSignIn(emailController.text,passwordController.text),
                    child: Text(
                      snapshot.data != null ? 'Sign Out' : 'Sign In'
                    )
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => signInWithGoogle(),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(Icons.login_sharp),
                        SizedBox(width: 10),
                        Text('Sign in with Google')
                      ]
                    )
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => readFirebaseDatabase(),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(Icons.get_app),
                        SizedBox(width: 5),
                        Text('Get Firebase Data')
                      ],
                    )
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => uploeadFirebaseData(),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(Icons.upload),
                        SizedBox(width: 5),
                        Text('Upload Data to Firebase')
                      ]
                    )
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => removeFirebaseData(),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(Icons.remove),
                        SizedBox(width: 5),
                        Text('Remove Firebase Data')
                      ]
                    )
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => addDataFirebase(),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(Icons.add),
                        SizedBox(width: 5),
                        Text('Add Data to Firebase')
                      ]
                    )
                  )
                ]
              )
            )
          ]
        )
      );}
    );
  }

  //mwthod to Implement Firebase Database and read data from covid_info table
  Future<void> readFirebaseDatabase() async{
    await firebaseReference.once().then((DataSnapshot snapshot) => {
      print(snapshot)
    });
  }

  Future<void> uploeadFirebaseData() async{
    await firebaseReference.update({
      'stateVaccineUrl': 'https://www.mohfw.gov.in/pdf/CummulativeCovidVaccinationReport13october2021.pdf'
    });
  }

  Future<void> removeFirebaseData() async{
    await firebaseReference.child('corona').remove();
  }

  Future<void> addDataFirebase() async{
    await firebaseReference.update({'corona': 'THis is new data'});
  }

  //
  Future<void> userSignOut() async{
    await FirebaseAuth.instance.signOut();
  }

  Future<void> userSignIn(String email,String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



  Future<void> createUser(String email,String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

} 