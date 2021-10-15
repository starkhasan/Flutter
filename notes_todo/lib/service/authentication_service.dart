import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  StreamController<bool> firebaseCleanDataController = StreamController<bool>();

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Stream<bool> get onFireBaseDataChange => firebaseCleanDataController.stream;

  // AuthenticationService() {
  //   DeletedFirebaseDatabase().onFirebaseDeleteDatabase.listen((event) {
  //     _firebaseCleanDataController.add(event);
  //   });
  // }
}
