import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hun_app/Screens/Register.dart';
import 'package:hun_app/auth/auth.dart';
import 'package:hun_app/auth/auth_provider.dart';

class Login extends StatefulWidget {
  @override
  createState() =>  LoginState();
}

class LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
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
        final String userId =
            await auth.signInWithEmailAndPassword(_email, _password);
        print(userId);
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  _hunLogo() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.1,
      height: MediaQuery.of(context).size.width / 2.1,
      decoration:  BoxDecoration(
        shape: BoxShape.rectangle,
        image:  DecorationImage(
            fit: BoxFit.fill, image: AssetImage('assets/images/HunLogo1.png')),
      ),
    );
  }

  _paddingTitle() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Text(
            'HUN',
            style:  TextStyle(
              fontSize: MediaQuery.of(context).size.height / 14,
              fontFamily: 'Ancízar Sans Bold',
              color: const Color(0xFF1266A4),
            ),
          ),
          Text(
            'Salud',
            style:  TextStyle(
              fontSize: MediaQuery.of(context).size.height / 14,
              fontFamily: 'Ancízar Sans Light',
              color: const Color(0xFF1266A4),
            ),
          )
        ],
      ),
    );
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
  }

  _textFormField(String hintText, bool obscureText) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      width: MediaQuery.of(context).size.width / 1.8,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.height / 34,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      MediaQuery.of(context).size.height / 34,
                    ),
                    topLeft: Radius.circular(
                      MediaQuery.of(context).size.height / 34,
                    ),
                  ),
                  color: Color(0xffF1F1F1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.3,
                height: MediaQuery.of(context).size.height / 15,
                decoration:  BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffF1F1F1),
                ),
                child: TextFormField(
                  key: !obscureText ? Key('email') : Key("password"),
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  style:  TextStyle(
                    fontFamily: 'Ancízar Sans Light',
                    fontSize: MediaQuery.of(context).size.height / 39,
                    color: Color.fromRGBO(158, 158, 158, 1),
                  ),
                  decoration:  InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontFamily: 'Ancízar Sans Light',
                      fontSize: MediaQuery.of(context).size.height / 39,
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
                  onSaved: (String value) {
                    if (!obscureText) {
                      _email = value;
                    } else {
                      _password = value;
                    }
                  },
                  validator: null,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.height / 34,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      MediaQuery.of(context).size.height / 34,
                    ),
                    topRight: Radius.circular(
                      MediaQuery.of(context).size.height / 34,
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

  _mainButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: this.validateAndSubmit,
        color: Color(0xffFF8800),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height / 34),
        ),
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

  _offTopicButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          _formKey.currentState.reset();
          return setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Register(),
              ),
            );
          });
        },
        color: Color(0xFF1266A4),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height / 35)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _spaceBetween(40),
                    Hero(tag: 'hunLogo', child: _hunLogo()),
                    _paddingTitle(),
                    _spaceBetween(20),
                    _textFormField('Usuario/Email', false),
                    _spaceBetween(1),
                    _textFormField('Contraseña', true),
                    _spaceBetween(20),
                    _mainButton(
                      'Iniciar Sesión',
                      MediaQuery.of(context).size.height / 16,
                      MediaQuery.of(context).size.width / 2,
                    ),
                    _spaceBetween(5),
                    Text(
                      '¿Es usuario nuevo?',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 39,
                        fontFamily: 'Ancízar Sans Light',
                        color: Color(0xff707070),
                      ),
                    ),
                    _offTopicButton(
                      'Registrarse',
                      MediaQuery.of(context).size.height / 16,
                      MediaQuery.of(context).size.width / 2.1,
                    ),
                    _spaceBetween(20)
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
