import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'HunRegister.dart';
import 'LogIn.dart';

class HunLogin extends StatefulWidget {
  @override
  createState() => new HunLoginState();
}

class HunLoginState extends State<HunLogin> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _hunLogo() {
    return Container(
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
                fontFamily: 'Ancízar Sans Bold',
                color: const Color(0xFF1266A4),
              )),
          Text('Salud',
              style: new TextStyle(
                fontSize: 40,
                fontFamily: 'Ancízar Sans Light',
                color: const Color(0xFF1266A4),
              ))
        ]));
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
  }

  _textField(String hintText, bool obscureText) {
    return Container(
      height: 38,
      width: 200,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 38,
                width: 19,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(19),
                    topLeft: Radius.circular(19),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                width: 162,
                height: 38,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                height: 38,
                width: 19,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(19),
                    topRight: Radius.circular(19),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
            ],
          ),
          Positioned(
            left: 19,
            width: 180,
            bottom: -3,
            child: TextField(
                obscureText: obscureText,
                textAlign: TextAlign.left,
                style: new TextStyle(
                    fontFamily: 'Ancízar Sans Light',
                    fontSize: 14,
                    color: Color.fromRGBO(158, 158, 158, 1)),
                decoration: new InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontFamily: 'Ancízar Sans Light',
                        fontSize: 14,
                        color: Color.fromRGBO(158, 158, 158, 1)),
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

  _mainButton(String buttonText, double height, double width) {
    _onPressed() {
      return setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => LogIn()));
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      height: height,
      width: width,
    );
  }

  _offTopicButton(String buttonText, double height, double width) {
    _onPressed() {
      return setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HunRegister()));
      });
    }

    return Container(
      child: RaisedButton(
        onPressed: () {
          _onPressed();
        },
        color: Color(0xFF1266A4),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 14, color: Colors.white),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _spaceBetween(40),
                  Hero(tag: 'hunLogo', child: _hunLogo()),
                  _paddingTitle(),
                  _spaceBetween(30),
                  _textField('Usuario/Email', false),
                  _spaceBetween(10),
                  _textField('Contraseña', true),
                  _spaceBetween(30),
                  _mainButton('Iniciar Sesión', 38, 200),
                  _spaceBetween(20),
                  Text(
                    '¿Es usuario nuevo?',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070)),
                  ),
                  _offTopicButton('Registrarse', 38, 200),
                  _spaceBetween(20)
                ],
              )
            ],
          ),
        ));
  }
}
