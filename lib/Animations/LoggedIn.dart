import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hun_app/Screens/Home.dart';

class LoggedIn extends StatefulWidget {
  @override
  createState() => new LoggedInState();
}

class LoggedInState extends State<LoggedIn> with TickerProviderStateMixin {

  AnimationController rotationController;
  Animation rotationAnimation;
  AnimationController fadeController;
  Animation fadeAnimation;
  Timer time;

  @override
  void initState() {
    super.initState();

    rotationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    rotationAnimation = new Tween(begin: 0.0, end: 0.5).animate(rotationController);

    fadeController =
        new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    fadeAnimation = new Tween(begin: 1.0, end: 0.0).animate(fadeController);

    rotationController.addStatusListener((rotationStatus) {
      if (rotationStatus == AnimationStatus.completed) {
        fadeController.forward();
      }else if(rotationStatus == AnimationStatus.dismissed){
        rotationController.forward();
      }
    });

    fadeController.addStatusListener((fadeStatus) {
      if (fadeStatus == AnimationStatus.completed) {
        fadeController.reverse();
      }else if(fadeStatus == AnimationStatus.dismissed){
        rotationController.repeat();
        time = new Timer(Duration(seconds: 1), (){
          setState(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Home()), (_) => false);
          });
        });
      }
    });

    rotationController.addListener((){
      setState(() {

      });
    });
  }

  void dispose() {
    fadeController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    rotationController.forward();
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'hunLogo',
          child: RotationTransition(
              turns: rotationAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.1,
                  height: MediaQuery.of(context).size.width / 2.1,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/HunLogo1.png')),
                  ),
                ),
              )),
        )
      ),
    );
  }
}
