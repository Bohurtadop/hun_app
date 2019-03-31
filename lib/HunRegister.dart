import "package:flutter/material.dart";

class HunRegister extends StatefulWidget{
  @override
  HunRegisterState createState() => new HunRegisterState();
}

class HunRegisterState extends State<HunRegister> with TickerProviderStateMixin{
  @override
  void initState(){
    super.initState();
  }

  _darkTittle(String tittle){
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

  _hunLogoAndTittle(){
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

  Widget build(BuildContext context){
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
                    _tittleTextField('Nombres'),
                    _textField('Nombres', false),
                    _tittleTextField('Apellidos'),
                    _textField('Apellidos', false),
                    _tittleTextField('Email'),
                    _textField('Email', false),
                    _tittleTextField('Contraseña'),
                    _textField('Contraseña', false),
                    _tittleTextField('Repetir contraseña'),
                    _textField('Contraseña', false),
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