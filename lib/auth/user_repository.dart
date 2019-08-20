import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  AuthStatus _status = AuthStatus.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  AuthStatus get status => _status;

  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    debugPrint('[User repository] Sign in has been called.');
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();

      debugPrint('[User repository] Auth status: ${_status.toString()}');

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      debugPrint('[User repository] Succesful login with email and password.');

      return true;
    } catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();

      debugPrint('[User repository] Exception catched: ${e.toString()}');
      debugPrint('[User repository] Auth status: ${_status.toString()}');

      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    debugPrint('[User repository] Sign up has been called.');
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();

      debugPrint('[User repository] Auth status: ${_status.toString()}');

      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        debugPrint(
            '[User repository] Succesful register with email and password.');
        debugPrint('[User repository] User\'s id: ${_user.uid}');
      });
      return Future.delayed(Duration(milliseconds: 500), () => true);
    } catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();

      debugPrint('[User repository] Exception catched: ${e.toString()}');
      debugPrint('[User repository] Auth status: ${_status.toString()}');

      return false;
    }
  }

  Future signOut() async {
    debugPrint('[User repository] Sign out has been called.');
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();

    debugPrint('[User repository] User has signed out.');
    debugPrint('[User repository] Auth status: ${_status.toString()}');

    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    debugPrint('[User repository] Auth state listener callback.');
    debugPrint('[User repository] Previous auth status: ${_status.toString()}');
    debugPrint('[User repository] Auth status has changed.');

    if (firebaseUser == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();

    debugPrint('[User repository] Auth status: ${_status.toString()}');
  }
}
