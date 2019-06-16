import 'package:flutter/material.dart';
import 'package:hun_app/Animations/Loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    checkerboardOffscreenLayers: false,
    checkerboardRasterCacheImages: false,
    theme: ThemeData(fontFamily: 'Ancízar Sans Regular',
      primaryColor: Color(0xff1266A4),
      accentColor: Color(0xff1266A4),
      dialogBackgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
    ),
    home: Loading(),
  ));
}
