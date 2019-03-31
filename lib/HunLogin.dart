import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'HunRegister.dart';
import 'LogIn.dart';

GlobalKey logo = new GlobalKey();

class HunLogin extends StatefulWidget {
  @override
  createState() => new HunLoginState();
}

double getLogoPosition() {
  RenderBox box = logo.currentContext.findRenderObject();
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  return position.dy;
}

class HunLoginState extends State<HunLogin> with TickerProviderStateMixin {

  double beginY = 0.0;
  double totalY = 0.0;
  double logoAlignmentY = 0.0;
  var _y = - 1.0;
  var variables = false;
  Timer time;
  bool firstStateEnabled = true;

  void dispose(){
    super.dispose();
  }

  animateState() {
    this.totalY = MediaQuery.of(context).size.height;
    this.beginY = getLogoPosition();
    this.logoAlignmentY = ((beginY * 2) / totalY) - 1;
    this._y = beginY;
    setState(() {
      firstStateEnabled = false;
    });
  }

  _hunLogo(Key key) {
    return Container(
      key: key,
      width: 190,
      height: 190,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        image: new DecorationImage(
            fit: BoxFit.fill, image: AssetImage('assets/images/HunLogo1.png')),
      ),
    );
  }

  _paddingTitle() {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Row(children: <Widget>[
          Text('HUN',
              style: new TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1266A4),
              )),
          Text('Salud',
              style: new TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF1266A4),
              ))
        ]));
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
  }

  _tittleTextField(String tittle) {
    return Row(
      children: <Widget>[
        Container(
          width: 18,
        ),
        Container(
          width: 230,
          child: Text(
            tittle,
            textAlign: TextAlign.left,
            style: TextStyle(color: Color(0xff707070), fontSize: 20),
          ),
        ),
      ],
    );
  }

  _textField(String hintText, bool obscureText) {
    return Container(
      height: 36,
      width: 248,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 36,
                width: 18,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                width: 210,
                height: 36,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                height: 36,
                width: 18,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
            ],
          ),
          Positioned(
            left: 18,
            width: 220,
            bottom: -5,
            child: TextField(
              obscureText: obscureText,
                textAlign: TextAlign.left,
                style: new TextStyle(
                    fontSize: 20, color: Color.fromRGBO(158, 158, 158, 1)),
                decoration: new InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(158, 158, 158, 1)),
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none)))),
          )
        ],
      ),
    );
  }

  _mainButton(String buttonText, double height, double width){

    _onPressed(){
      return setState(() {
        animateState();
        _y = 0.0;
        time = new Timer(Duration(seconds: 1), () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LogIn()));
          });
        });
      });
    }

    return Container(
      child: RaisedButton(
        onPressed: () {
          _onPressed();
        },
        color: Color(0xffFF8800),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      height: height,
      width: width,
    );
  }

  _offTopicButton(String buttonText, double height, double width){

    _onPressed(){
      return setState((){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    HunRegister()));
      });
    }

    return Container(
      child: RaisedButton(
        onPressed: (){
          _onPressed();
        },
        color: Color(0xff74BEE7),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      height: height,
      width: width,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AnimatedCrossFade(
              firstChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _spaceBetween(30),
                      _hunLogo(logo),
                      _paddingTitle(),
                      _spaceBetween(20),
                      _tittleTextField('Usuario/Email'),
                      _textField('Usuario/Email', false),
                      _tittleTextField('Contraseña'),
                      _textField('Contraseña', true),
                      _spaceBetween(5),
                      _mainButton('Iniciar Sesión', 46, 200),
                      _spaceBetween(20),
                      Text(
                        '¿Es usuario nuevo?',
                        style: TextStyle(fontSize: 15, color: Color(0xff707070)),
                      ),
                      _offTopicButton('Registrarse', 32, 140),
                      _spaceBetween(40)
                    ],
                  )
                ],
              ),
              secondChild: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedContainer(
                        alignment: Alignment(0.0, _y),
                        child: _hunLogo(null),
                        duration: Duration(seconds: 1),
                      )
                    ]),
              ),
              crossFadeState: firstStateEnabled
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(seconds: 1)),
        )
      ),
    );
  }
}
