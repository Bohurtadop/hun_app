import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:hun_app/Animations/auth_updating.dart';
import 'package:hun_app/auth/user_repository.dart';
import 'package:hun_app/resources/Resources.dart';

GlobalKey pass = GlobalKey();
GlobalKey passRepeat = GlobalKey();

class Register extends StatefulWidget {
  final UserRepository _user;

  Register(this._user);

  @override
  createState() => RegisterState();
}

class RegisterState extends State<Register> with TickerProviderStateMixin {
  TextEditingController _passwordController;
  TextEditingController _emailController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Icon _emailIcon = Icon(null);
  Icon _passIcon = Icon(null);

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

  Future<void> validateAndSubmit(BuildContext _context) async {
    if (this.validateAndSave()) {
      if (_firstNameController.text.isEmpty || _firstNameController.text == null)
        return showToast(context: _context, message: 'Verifica el nombre que has ingresado');
      
      if (_lastNameController.text.isEmpty || _lastNameController.text == null)
        return showToast(context: _context, message: 'Verifica el nombre que has ingresado');
      try {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AuthAnimation()),
          );
        });
        await widget._user
            .signUp(_emailAddress, _password)
            .then((success) async {
          if (success) {
            FirebaseUser user = widget._user.user;
            Navigator.pop(context);

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
                .call({'client': true});
            print('User type has been updated. The user is a client now.');
          } else {
            showToast(
                context: _context, message: 'Error en la creación del usuario.', milliseconds: 1000);
          }
        });
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
                    decoration: BoxDecoration(
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
                    decoration: BoxDecoration(
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
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070),
                      ),
                      decoration: InputDecoration(
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
                    decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                        this._emailIcon = Icon(null);
                      }
                    });
                  },
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 39,
                    fontFamily: 'Ancízar Sans Light',
                    color: Color(0xff707070),
                  ),
                  decoration: InputDecoration(
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
                decoration: BoxDecoration(
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
          Positioned(
            right: 2,
            width: MediaQuery.of(context).size.height / 19,
            height: MediaQuery.of(context).size.height / 19,
            child: _emailIcon,
          ),
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
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                        _passIcon = Icon(null);
                      }
                    });
                  },
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 39,
                      fontFamily: 'Ancízar Sans Light',
                      color: Color(0xff707070)),
                  decoration: InputDecoration(
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
                decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
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
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070)),
                    decoration: InputDecoration(
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
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
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
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 39,
                          fontFamily: 'Ancízar Sans Light',
                          color: Color(0xff707070)),
                      decoration: InputDecoration(
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
                  decoration: BoxDecoration(
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext _context) {
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
                          spaceBetween(40),
                          hunLogoAndTittle(context),
                          darkTitle(title: 'REGISTRO', context: context),
                          _textFormField(
                            _firstNameController,
                            'Nombres',
                            false,
                            key: 'first name',
                          ),
                          _textFormField(
                            _lastNameController,
                            'Apellidos',
                            false,
                            key: 'last name',
                          ),
                          spaceBetween(5),
                          _textFormField(
                            _emailController,
                            'Email',
                            false,
                            key: 'email',
                          ),
                          _emailTextField(
                              _emailController, 'Repetir email', false),
                          spaceBetween(5),
                          _textFormField(
                            _passwordController,
                            'Contraseña',
                            true,
                            key: 'password',
                          ),
                          _passwordTextField(
                            _passwordController,
                            'Repetir contraseña',
                            true,
                          ),
                          _tittleTextField('Fecha de nacimiento'),
                          _birthDateField(),
                          spaceBetween(15),
                          mainButton(
                            context: context,
                            buttonText: 'Registrarse',
                            onPressed: () => this.validateAndSubmit(_context),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 16,
                          ),
                          spaceBetween(10),
                          Text(
                            '¿Tiene una cuenta?',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 39,
                              fontFamily: 'Ancízar Sans Light',
                              color: Color(0xff707070),
                            ),
                          ),
                          offTopicButton(
                            context: context,
                            buttonText: 'Iniciar sesión',
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 2.1,
                            onPressed: () => Navigator.pop(context),
                          ),
                          spaceBetween(30)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
