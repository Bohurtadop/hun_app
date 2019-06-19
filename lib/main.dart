import 'package:flutter/material.dart';
import 'package:hun_app/Animations/Loading.dart';
import 'package:hun_app/auth/auth.dart';
import 'package:hun_app/auth/auth_provider.dart';

void main() {
  runApp(new HUN());
}

class HUN extends StatelessWidget {
  const HUN({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        checkerboardOffscreenLayers: false,
        checkerboardRasterCacheImages: false,
        theme: ThemeData(
          fontFamily: 'Ancízar Sans Regular',
          primaryColor: Color(0xff1266A4),
          accentColor: Color(0xff1266A4),
          dialogBackgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
        ),
        home: Loading(),
      ),
    );
  }
}
