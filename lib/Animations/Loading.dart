import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/auth/root_page.dart';
import 'package:hun_app/resources/Resources.dart';

class Loading extends StatefulWidget {
  @override
  createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  bool firstStateEnabled = true;
  Timer fadeTime;
  Timer nextTime;

  @override
  void initState() {
    fadeTime = Timer(
      Duration(seconds: 2),
      () => setState(() => firstStateEnabled = false),
    );
    nextTime = Timer(
      Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => RootPage()),
        (_) => false,
      ),
    );
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _sansTittle(String tittle) {
    return Text(
      tittle,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 18,
        fontFamily: 'Ancízar Sans Regular',
        color: const Color(0xFF1266A4),
      ),
    );
  }

  _serifTittle(String tittle) {
    return Text(
      tittle,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 20,
        fontFamily: 'Ancízar Serif Regular',
        color: const Color(0xFF1266A4),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedCrossFade(
                  firstChild: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.9,
                          height: MediaQuery.of(context).size.width / 1.9,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/HunLogo3.png'),
                            ),
                          ),
                        ),
                        spaceBetweenVertical(10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: MediaQuery.of(context).size.width / 8,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                width: MediaQuery.of(context).size.width / 1.7,
                                top: 0,
                                child: Center(
                                  child: _serifTittle("HOSPITAL UNIVERSITARIO"),
                                ),
                              ),
                              Positioned(
                                width: MediaQuery.of(context).size.width / 1.7,
                                top: MediaQuery.of(context).size.width / 30,
                                child: Center(
                                  child: _sansTittle("N A C I O N A L"),
                                ),
                              ),
                              Positioned(
                                width: MediaQuery.of(context).size.width / 1.7,
                                top: MediaQuery.of(context).size.width / 14,
                                child: Center(
                                  child: _serifTittle("DE COLOMBIA"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  secondChild: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(tag: 'hunLogo', child: hunLogo(context)),
                            paddingTitle(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: firstStateEnabled
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
