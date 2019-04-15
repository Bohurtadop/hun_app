import 'package:flutter/material.dart';
import 'Loading.dart';
import 'HunLogin.dart';

void main() {
  runApp(MaterialApp(
    title: 'HUN Aplication',
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    checkerboardOffscreenLayers: false,
    checkerboardRasterCacheImages: false,
    theme: ThemeData(fontFamily: 'Ancízar Sans Regular'),
    home: Loading(),
  ));
}


