import "package:flutter/material.dart";

GlobalKey pass = new GlobalKey();
GlobalKey passRepeat = new GlobalKey();

class HunRegister extends StatefulWidget {
  @override
  HunRegisterState createState() => new HunRegisterState();
}

class HunRegisterState extends State<HunRegister>
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
      padding: EdgeInsets.all(30),
      child: Text(
        tittle,
        textDirection: TextDirection.ltr,
        style: new TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
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
      Container(
        width: 60,
        height: 60,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/HunLogo1.png')),
        ),
      ),
      Padding(
          padding: EdgeInsets.all(20),
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
          ])),
    ]);
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

  _textField(
      TextEditingController controller, String hintText, bool obscureText) {
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
                controller: controller,
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

  _emailTextField(TextEditingController controller, String hintText, bool obscureText) {
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
                    if (controller.text == null || pass == null){
                      _emailIcon = null;
                    }
                  });
                },
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
          ),
          Positioned(right: 2, width: 36, height: 36, child: _emailIcon),
        ],
      ),
    );
  }

  _passTextField(TextEditingController controller, String hintText, bool obscureText) {
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
                    if (controller.text == null || pass == null){
                      _passIcon = null;
                    }
                  });
                },
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
          ),
          Positioned(right: 2, width: 36, height: 36, child: _passIcon),
        ],
      ),
    );
  }

  _birthDateField() {
    _textFieldDateSmall(
        TextEditingController controller, String hintText, bool obscureText) {
      return Container(
        height: 36,
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
                  width: 40,
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
              width: 40,
              bottom: -5,
              child: TextField(
                  controller: controller,
                  maxLength: 2,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  obscureText: obscureText,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 20, color: Color.fromRGBO(158, 158, 158, 1)),
                  decoration: new InputDecoration(
                      counterText: '',
                      hintText: hintText,
                      hintStyle: TextStyle(
                          fontSize: 20,
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

    _textFieldDateBig(
        TextEditingController controller, String hintText, bool obscureText) {
      return Container(
        height: 36,
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
                  width: 60,
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
              width: 60,
              bottom: -5,
              child: TextField(
                  controller: controller,
                  maxLength: 4,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  obscureText: obscureText,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 20, color: Color.fromRGBO(158, 158, 158, 1)),
                  decoration: new InputDecoration(
                      counterText: '',
                      hintText: hintText,
                      hintStyle: TextStyle(
                          fontSize: 20,
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
          setState(() {
            Navigator.pop(context);
          });
        },
        color: Color(0xffFF8800),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _spaceBetween(30),
                  _hunLogoAndTittle(),
                  _darkTittle('REGISTRO'),
                  _textField(null, 'Nombres', false),
                  _textField(null, 'Apellidos', false),
                  _textField(emailController, 'Email', false),
                  _emailTextField(emailController, 'Repetir email', false),
                  _textField(passController, 'Contraseña', true),
                  _passTextField(passController, 'Repetir contraseña', true),
                  _tittleTextField('Fecha de nacimiento'),
                  _birthDateField(),
                  _spaceBetween(20),
                  _mainButton('Registrarse', 46, 200),
                  _spaceBetween(40)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
