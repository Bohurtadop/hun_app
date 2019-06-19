import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:hun_app/auth/auth.dart';
import 'package:hun_app/auth/auth_provider.dart';

GlobalKey pass = new GlobalKey();
GlobalKey passRepeat = new GlobalKey();

class Register extends StatefulWidget {
  @override
  createState() => new RegisterState();
}

class RegisterState extends State<Register> with TickerProviderStateMixin {
  TextEditingController _passwordController;
  TextEditingController _emailController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Icon _emailIcon = new Icon(null);
  Icon _passIcon = new Icon(null);

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  String _emailAddress;
  String _password;

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (this.validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        final FirebaseUser user =
            await auth.createUserWithEmailAndPassword(_emailAddress, _password);
        print(user.uid);

        setState(() {
          Navigator.pop(context);
        });

        // email verification
        await CloudFunctions.instance
            .getHttpsCallable(functionName: 'update_user_name')
            .call({
          'name': '${_firstNameController.text} ${_lastNameController.text}'
        }).then((dynamic onValue) async {
          await user.sendEmailVerification();
          print(onValue);
        });
        print('Verification email has been sent');

        // user type defining
        await CloudFunctions.instance
            .getHttpsCallable(functionName: 'update_user_type')
            .call({'user_type': 'Usuario particular'});
        print('User type has been modifed to Usuario particular');
      } catch (e) {
        print('Error: ${e.toString()}');
      }
    }
  }

  @override
  void initState() {
    this._passwordController = TextEditingController();
    this._emailController = TextEditingController();
    this._firstNameController = TextEditingController();
    this._lastNameController = TextEditingController();
    super.initState();
  }

  void dispose() {
    this._emailController.dispose();
    this._passwordController.dispose();
    this._firstNameController.dispose();
    this._lastNameController.dispose();
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
      TextEditingController controller, String hintText, bool obscureText,
      {String key}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 19,
          width: (MediaQuery.of(context).size.width / 2) +
              (MediaQuery.of(context).size.height / 19) +
              1,
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.height / 38,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.height / 38,
                        ),
                        topLeft: Radius.circular(
                          MediaQuery.of(context).size.height / 38,
                        ),
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
                      key: key != '' ? Key(key) : null,
                      onSaved: (String value) {
                        if (!obscureText && key == 'email') {
                          _emailAddress =
                              _emailController.text == value ? value : null;
                        } else if (obscureText && key == 'password') {
                          _password =
                              _passwordController.text == value ? value : null;
                        }
                      },
                      validator: null,
                      controller: controller,
                      obscureText: obscureText,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070),
                      ),
                      decoration: new InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 39,
                          fontFamily: 'Ancízar Sans Light',
                          color: Color.fromRGBO(158, 158, 158, 1),
                        ),
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.height / 38,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                            MediaQuery.of(context).size.height / 38),
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.height / 38),
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
      width: (MediaQuery.of(context).size.width / 2) +
          (MediaQuery.of(context).size.height / 19) +
          1,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      MediaQuery.of(context).size.height / 38,
                    ),
                    topLeft: Radius.circular(
                      MediaQuery.of(context).size.height / 38,
                    ),
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
                  onChanged: (String email) {
                    setState(() {
                      if (controller.text == email) {
                        this._emailIcon = Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        );
                      } else {
                        this._emailIcon = Icon(
                          Icons.cancel,
                          color: Colors.red,
                        );
                      }
                      if (email == '') {
                        this._emailIcon = new Icon(null);
                      }
                    });
                  },
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 39,
                    fontFamily: 'Ancízar Sans Light',
                    color: Color(0xff707070),
                  ),
                  decoration: new InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color.fromRGBO(158, 158, 158, 1)),
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                        MediaQuery.of(context).size.height / 38),
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.height / 38),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
            ],
          ),
          Positioned(
              right: 2,
              width: MediaQuery.of(context).size.height / 19,
              height: MediaQuery.of(context).size.height / 19,
              child: _emailIcon),
        ],
      ),
    );
  }

  _passwordTextField(
      TextEditingController controller, String hintText, bool obscureText) {
    return Container(
      height: MediaQuery.of(context).size.height / 19,
      width: (MediaQuery.of(context).size.width / 2) +
          (MediaQuery.of(context).size.height / 19) +
          1,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        MediaQuery.of(context).size.height / 38),
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.height / 38),
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
                  onChanged: (String password) {
                    setState(() {
                      if (controller.text == password) {
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
                      if (password == '') {
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
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 19,
                width: MediaQuery.of(context).size.height / 38,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                        MediaQuery.of(context).size.height / 38),
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.height / 38),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
            ],
          ),
          Positioned(
              right: 2,
              width: MediaQuery.of(context).size.height / 19,
              height: MediaQuery.of(context).size.height / 19,
              child: _passIcon),
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
                      bottomLeft: Radius.circular(
                        MediaQuery.of(context).size.height / 38,
                      ),
                      topLeft: Radius.circular(
                        MediaQuery.of(context).size.height / 38,
                      ),
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
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 19,
                  width: MediaQuery.of(context).size.height / 38,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                        MediaQuery.of(context).size.height / 38,
                      ),
                      topRight: Radius.circular(
                        MediaQuery.of(context).size.height / 38,
                      ),
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
                      bottomLeft: Radius.circular(
                        MediaQuery.of(context).size.height / 38,
                      ),
                      topLeft: Radius.circular(
                        MediaQuery.of(context).size.height / 38,
                      ),
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
                              borderSide:
                                  BorderSide(style: BorderStyle.none)))),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 19,
                  width: MediaQuery.of(context).size.height / 38,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.height / 38),
                      topRight: Radius.circular(
                          MediaQuery.of(context).size.height / 38),
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
        onPressed: this.validateAndSubmit,
        color: Color(0xffFF8800),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height / 34)),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 39,
              color: Colors.white),
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
          child: Form(
            key: this._formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _spaceBetween(40),
                    _hunLogoAndTittle(),
                    _darkTittle('REGISTRO'),
                    _textFormField(_firstNameController, 'Nombres', false,
                        key: 'first name'),
                    _textFormField(_lastNameController, 'Apellidos', false,
                        key: 'last name'),
                    _textFormField(_emailController, 'Email', false,
                        key: 'email'),
                    _emailTextField(_emailController, 'Repetir email', false),
                    _textFormField(_passwordController, 'Contraseña', true,
                        key: 'password'),
                    _passwordTextField(
                        _passwordController, 'Repetir contraseña', true),
                    _tittleTextField('Fecha de nacimiento'),
                    _birthDateField(),
                    _spaceBetween(15),
                    _mainButton(
                        'Registrarse',
                        MediaQuery.of(context).size.height / 16,
                        MediaQuery.of(context).size.width / 2),
                    _spaceBetween(30)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
