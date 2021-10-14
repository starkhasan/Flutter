import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthSevice {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }
}
