import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_todo/utils/deleted_firebase_database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  StreamController<bool> _firebaseCleanDataController =
      StreamController<bool>();

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Stream<bool> get onFireBaseDataChange => _firebaseCleanDataController.stream;

  // AuthenticationService() {
  //   DeletedFirebaseDatabase().onFirebaseDeleteDatabase.listen((event) {
  //     _firebaseCleanDataController.add(event);
  //   });
  // }
}
