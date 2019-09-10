import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:hun_app/Animations/auth_updating.dart';
import 'package:hun_app/auth/root_page.dart';
import 'package:hun_app/auth/user_repository.dart';
import 'package:hun_app/resources/Resources.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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

  /// First name controller
  /// This is used in the TextFormField
  TextEditingController _fnController;

  /// Last name controller
  TextEditingController _lastnameController;

  String _emailAddress;
  String _password;

  /// Terms of conditions checkbox state
  bool _termsOfCond = false;

  /// This function changes the value of [_termsOfCond]
  /// when the user has interacted with the checkbox
  void _onTOCChanged(bool value) {
    setState(() => _termsOfCond = value);
    debugPrint('[Register] Checkbox state: $value');
  }

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  DateTime _birthday = DateTime.now();
  bool _validDate = false;

  Future<void> _datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _birthday,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 140)),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final age = DateTime.now().difference(picked);
      setState(() {
        _birthday = picked;
        _validDate = age.inDays / 365 >= 18.01;
      });
      debugPrint(
          "[Register] Date selected day: ${_birthday.day} | month: ${_birthday.month} | year: ${_birthday.year}");
      debugPrint('[Register] Actual age is ${(age.inDays / 365)}');
      debugPrint('[Register] Is not under 18? ${age.inDays / 365 >= 18.01}');
    }
  }

  Future<void> validateAndSubmit(BuildContext _context) async {
    if (this.validateAndSave()) {
      if (!this._termsOfCond) {
        debugPrint('[Register] User has not accepted TOC: $_termsOfCond');
        return acceptTOC(context: _context);
      }
      if (_fnController.text == null || _fnController.text.length < 2) {
        debugPrint('[Register] Invalid name');
        return showToast(
          context: _context,
          message: 'Verifica el nombre que has ingresado.',
          milliseconds: 1000,
        );
      }

      if (_lastnameController.text == null ||
          _lastnameController.text.length < 2) {
        return showToast(
          context: _context,
          message: 'Verifica el apellido que has ingresado.',
          milliseconds: 1000,
        );
      }

      if (!_validDate) {
        return showToast(
          context: _context,
          message: 'Debes ser mayor de edad para registrarte.',
          milliseconds: 1000,
        );
      }
      try {
        debugPrint('[Register] Before AuthAnimation');
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AuthAnimation(),
            ),
          ).whenComplete(() {
            return debugPrint('[Register] AuthAnimation has finished');
          });
        });
        debugPrint('[Register] After AuthAnimation');
        debugPrint('[Register] Before creating user');
        await widget._user
            .signUp(_emailAddress, _password)
            .then((success) async {
          if (success) {
            FirebaseUser user = widget._user.user;
            debugPrint('[Register] User has been created -> uid: ${user.uid}');

            const function_name = 'update_user';
            var parameters = {
              'name': '${_fnController.text} ${_lastnameController.text}',
              'client': true,
              'doctor': false,
              'birthday': _birthday.toUtc().millisecondsSinceEpoch
            };

            debugPrint(
                '[Register] Parameter for calling $function_name are $function_name');
            debugPrint(
                '[Register] Before calling the CloudFuntion $function_name');

            await CloudFunctions.instance
                .getHttpsCallable(functionName: function_name)
                .call(parameters)
                .then((HttpsCallableResult onValue) async {
              debugPrint('[Register] --------then() started--------{');

              // FIXME: By now we will force to puh to RootPage
              // When we pop it does not pop that quick. This error was presented:
              // Error: NoSuchMethodError: The method 'ancestorStateOfType' was called on null.
              debugPrint('[Register] Before pushing to RootPage');

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => RootPage()),
                (_) => false,
              ).whenComplete(() {
                return debugPrint(
                    '[Register] Push to RootPage has been completed.');
              });

              debugPrint('[Register] After pushing to RootPage');

              debugPrint('[Register] Value from update_user: ${onValue.data}');
              debugPrint(
                  '[Register] User type and name has been updated. The user must a client now.');

              // email verification
              debugPrint('[Register] Before sending email verification');
              await user.sendEmailVerification();
              debugPrint('[Register] Verification email has been sent');
              debugPrint('[Register] }--------then() finished--------');
            });
            debugPrint(
                '[Register] After calling the CloudFuntion $function_name');
            debugPrint('[Register] --------------------------------');
          } else {
            debugPrint('[Register] User could not be created.');
            showToast(
              context: _context,
              message:
                  'Tu usuario no ha podido ser creado. Quizás escribiste mal tu correo o ya estás registrado.',
              milliseconds: 1000,
            );
          }
        });
      } catch (e) {
        debugPrint('[Register] Error: ${e.toString()}');
      }
    }
  }

  @override
  void initState() {
    debugPrint('[Register] Checkbox initial state: $_termsOfCond');
    this._passwordController = TextEditingController();
    this._emailController = TextEditingController();
    this._fnController = TextEditingController();
    this._lastnameController = TextEditingController();
    super.initState();
  }

  void dispose() {
    this._emailController.dispose();
    this._passwordController.dispose();
    this._fnController.dispose();
    this._lastnameController.dispose();
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
                fontSize: MediaQuery.of(context).size.width / 18),
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

  Widget _birthDateField({@required BuildContext innerContext}) {
    initializeDateFormatting();
    var date = new DateFormat.yMMMd('es');

    return GestureDetector(
      onTap: () => _datePicker(innerContext),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            date.format(_birthday),
            style: TextStyle(
              color: _validDate
                  ? Theme.of(context).primaryColor
                  : Color(0xffFF5555),
              fontFamily: 'Ancízar Sans Light',
              fontSize: MediaQuery.of(context).size.width / 18,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 10),
          Icon(Icons.calendar_today),
        ],
      ),
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
                          spaceBetweenVertical(40),
                          hunLogoAndTittle(context),
                          darkTitle(title: 'REGISTRO', context: context),
                          _textFormField(
                            _fnController,
                            'Nombres',
                            false,
                            key: 'first name',
                          ),
                          spaceBetweenVertical(1),
                          _textFormField(
                            _lastnameController,
                            'Apellidos',
                            false,
                            key: 'last name',
                          ),
                          spaceBetweenVertical(1),
                          _textFormField(
                            _emailController,
                            'Email',
                            false,
                            key: 'email',
                          ),
                          spaceBetweenVertical(1),
                          _emailTextField(
                              _emailController, 'Confirmar email', false),
                          spaceBetweenVertical(1),
                          _textFormField(
                            _passwordController,
                            'Contraseña',
                            true,
                            key: 'password',
                          ),
                          spaceBetweenVertical(1),
                          _passwordTextField(
                            _passwordController,
                            'Repetir contraseña',
                            true,
                          ),
                          spaceBetweenVertical(1),
                          _tittleTextField('Fecha de nacimiento'),
                          _birthDateField(innerContext: _context),
                          spaceBetweenVertical(15),
                          checkBoxWithURL(
                            context: context,
                            onChanged: _onTOCChanged,
                            value: _termsOfCond,
                            text: toc_sign_up,
                          ),
                          mainButton(
                            context: context,
                            buttonText: 'Registrarse',
                            onPressed: () => this.validateAndSubmit(_context),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 16,
                          ),
                          spaceBetweenVertical(30)
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
