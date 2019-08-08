import 'package:flutter/material.dart';
import 'package:hun_app/Animations/LoggedIn.dart';
import 'auth_provider.dart';
import 'package:hun_app/Screens/Login.dart';
import 'auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? LoggedIn(snapshot.data) : Login();
        }
        return _buildWaitingScreen();
      },
    );
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
