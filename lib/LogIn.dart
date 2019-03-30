import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'HunHome.dart';

class LogIn extends StatefulWidget {
  @override
  LogInState createState() => new LogInState();
}

class LogInState extends State<LogIn> with TickerProviderStateMixin {

  AnimationController cont1;
  Animation anim1;
  AnimationController cont2;
  Animation anim2;
  Timer time;

  @override
  void initState() {
    super.initState();

    cont1 =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    anim1 = new Tween(begin: 0.0, end: 0.5).animate(cont1);

    cont2 =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    anim2 = new Tween(begin: 1.0, end: 0.0).animate(cont2);

    cont1.addStatusListener((status1) {
      if (status1 == AnimationStatus.completed) {
        cont2.forward();
      }else if(status1 == AnimationStatus.dismissed){
        cont1.forward();
      }
    });

    cont2.addStatusListener((status2) {
      if (status2 == AnimationStatus.completed) {
        cont2.reverse();
      }else if(status2 == AnimationStatus.dismissed){
        cont1.repeat();
        time = new Timer(Duration(seconds: 2), (){
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HunHome()));
          });
        });
      }
    });

    cont1.addListener((){
      setState(() {

      });
    });
  }

  void dispose() {
    cont2.dispose();
    cont1.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    cont1.forward();
    return Scaffold(
      body: Center(
        child: RotationTransition(
            turns: anim1,
            child: FadeTransition(
              opacity: anim2,
              child: Container(
                width: 190,
                height: 190,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/HunLogo1.png')),
                ),
              ),
            )),
      ),
    );
  }
}
