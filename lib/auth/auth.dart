import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Stream<String> get onAuthChanged;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password);
  Future<String> currentUserID();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String> get onAuthChanged {
    return _firebaseAuth.onAuthStateChanged.map((user) => user?.uid);
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user?.uid;
  }

  @override
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

  @override
  Future<String> currentUserID() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}