import "package:flutter/material.dart";

GlobalKey pass = new GlobalKey();
GlobalKey passRepeat = new GlobalKey();

class Register extends StatefulWidget {
  @override
  createState() => new RegisterState();
}

class RegisterState extends State<Register>
    with TickerProviderStateMixin {
  TextEditingController passController;
  TextEditingController emailController;

  Icon _emailIcon = new Icon(null);
  Icon _passIcon = new Icon(null);

  @override
  void initState() {
    passController = new TextEditingController();
    emailController = new TextEditingController();
    super.initState();
  }

  void dispose() {
    passController.dispose();
    super.dispose();
  }

  _darkTittle(String tittle) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        tittle,
        textDirection: TextDirection.ltr,
        style: new TextStyle(
            fontSize: MediaQuery.of(context).size.width / 12,
            fontFamily: 'Ancízar Sans Bold',
            color: Color(0xff707070)),
      ),
    );
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
  }

  _hunLogoAndTittle() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Hero(
        tag: 'hunLogo',
        child: Container(
          width: MediaQuery.of(context).size.width / 6,
          height: MediaQuery.of(context).size.width / 6,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/HunLogo1.png')),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.all(5),
          child: Row(children: <Widget>[
            Text('HUN',
                style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 10,
                  fontFamily: 'Ancízar Sans Bold',
                  color: const Color(0xFF1266A4),
                )),
            Text('Salud',
                style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 10,
                  fontFamily: 'Ancízar Sans Light',
                  color: const Color(0xFF1266A4),
                ))
          ])),
    ]);
  }

  _tittleTextField(String tittle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Text(
            tittle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Ancízar Sans Light',
                color: Color(0xff707070),
                fontSize: MediaQuery.of(context).size.height / 38),
          ),
        ),
      ],
    );
  }

  _textFormField(
      TextEditingController controller, String hintText, bool obscureText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 19,
          width: (MediaQuery.of(context).size.width / 2) + (MediaQuery.of(context).size.height / 19) + 1,
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.height / 38,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                      ),
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 19,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xffF1F1F1),
                    ),
                    child: TextFormField(
                        controller: controller,
                        obscureText: obscureText,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 39,
                            fontFamily: 'Ancízar Sans Light',
                            color: Color(0xff707070)),
                        decoration: new InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.height / 39,
                                fontFamily: 'Ancízar Sans Light',
                                color: Color.fromRGBO(158, 158, 158, 1)),
                            fillColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none)))),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.height / 38,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                        topRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                      ),
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  _emailTextField(
      TextEditingController controller, String hintText, bool obscureText) {
    return Container(
      height: MediaQuery.of(context).size.height / 19,
      width: (MediaQuery.of(context).size.width / 2) + (MediaQuery.of(context).size.height / 19) + 1,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                    topLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 19,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffF1F1F1),
                ),
                child: TextField(
                    onChanged: (String pass) {
                      setState(() {
                        if (controller.text == pass) {
                          _emailIcon = Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          );
                        } else {
                          _emailIcon = Icon(
                            Icons.cancel,
                            color: Colors.red,
                          );
                        }
                        if (pass == '') {
                          _emailIcon = new Icon(null);
                        }
                      });
                    },
                    obscureText: obscureText,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070)),
                    decoration: new InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 39,
                            fontFamily: 'Ancízar Sans Light',
                            color: Color.fromRGBO(158, 158, 158, 1)),
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none)))),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                    topRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
            ],
          ),
          Positioned(right: 2, width: MediaQuery.of(context).size.height / 19, height: MediaQuery.of(context).size.height / 19, child: _emailIcon),
        ],
      ),
    );
  }

  _passTextField(
      TextEditingController controller, String hintText, bool obscureText) {
    return Container(
      height: MediaQuery.of(context).size.height / 19,
      width: (MediaQuery.of(context).size.width / 2) + (MediaQuery.of(context).size.height / 19) + 1,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                    topLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 19,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffF1F1F1),
                ),
                child: TextField(
                    onChanged: (String pass) {
                      setState(() {
                        if (controller.text == pass) {
                          _passIcon = Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          );
                        } else {
                          _passIcon = Icon(
                            Icons.cancel,
                            color: Colors.red,
                          );
                        }
                        if (pass == '') {
                          _passIcon = new Icon(null);
                        }
                      });
                    },
                    obscureText: obscureText,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070)),
                    decoration: new InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 39,
                            fontFamily: 'Ancízar Sans Light',
                            color: Color.fromRGBO(158, 158, 158, 1)),
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none)))),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                    topRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
            ],
          ),
          Positioned(right: 2, width: MediaQuery.of(context).size.height / 19, height: MediaQuery.of(context).size.height / 19, child: _passIcon),
        ],
      ),
    );
  }

  _birthDateField() {
    _textFieldDateSmall(
        TextEditingController controller, String hintText, bool obscureText) {
      return Container(
        height: MediaQuery.of(context).size.height / 19,
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 19,
                  width: MediaQuery.of(context).size.height / 38,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                      topLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                    ),
                    color: Color(0xffF1F1F1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.height / 19,
                  height: MediaQuery.of(context).size.height / 19,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffF1F1F1),
                  ),
                  child: TextFormField(
                      controller: controller,
                      maxLength: 2,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      obscureText: obscureText,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 39,
                          fontFamily: 'Ancízar Sans Light',
                          color: Color(0xff707070)),
                      decoration: new InputDecoration(
                          counterText: '',
                          hintText: hintText,
                          hintStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 39,
                              fontFamily: 'Ancízar Sans Light',
                              color: Color.fromRGBO(158, 158, 158, 1)),
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none)))),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 19,
                  width: MediaQuery.of(context).size.height / 38,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                      topRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                    ),
                    color: Color(0xffF1F1F1),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    _textFieldDateBig(
        TextEditingController controller, String hintText, bool obscureText) {
      return Container(
        height: MediaQuery.of(context).size.height / 19,
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 19,
                  width: MediaQuery.of(context).size.height / 38,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                      topLeft: Radius.circular(MediaQuery.of(context).size.height / 38),
                    ),
                    color: Color(0xffF1F1F1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.height / 12,
                  height: MediaQuery.of(context).size.height / 19,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffF1F1F1),
                  ),
                  child: TextFormField(
                      controller: controller,
                      maxLength: 4,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      obscureText: obscureText,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 39,
                          fontFamily: 'Ancízar Sans Light',
                          color: Color(0xff707070)),
                      decoration: new InputDecoration(
                          counterText: '',
                          hintText: hintText,
                          hintStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 39,
                              fontFamily: 'Ancízar Sans Light',
                              color: Color.fromRGBO(158, 158, 158, 1)),
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none)))),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 19,
                  width: MediaQuery.of(context).size.height / 38,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                      topRight: Radius.circular(MediaQuery.of(context).size.height / 38),
                    ),
                    color: Color(0xffF1F1F1),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Row(
      children: <Widget>[
        _textFieldDateSmall(null, 'DD', false),
        _textFieldDateSmall(null, 'MM', false),
        _textFieldDateBig(null, 'AAAA', false),
      ],
    );
  }

  _mainButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Color(0xffFF8800),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 34)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: MediaQuery.of(context).size.height / 39, color: Colors.white),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _spaceBetween(40),
                  _hunLogoAndTittle(),
                  _darkTittle('REGISTRO'),
                  _textFormField(null, 'Nombres', false),
                  _textFormField(null, 'Apellidos', false),
                  _textFormField(emailController, 'Email', false),
                  _emailTextField(emailController, 'Repetir email', false),
                  _textFormField(passController, 'Contraseña', true),
                  _passTextField(passController, 'Repetir contraseña', true),
                  _tittleTextField('Fecha de nacimiento'),
                  _birthDateField(),
                  _spaceBetween(15),
                  _mainButton('Registrarse', MediaQuery.of(context).size.height / 16, MediaQuery.of(context).size.width / 2),
                  _spaceBetween(30)
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
