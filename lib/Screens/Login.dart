import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hun_app/Animations/auth_updating.dart';
import 'package:hun_app/Screens/Register.dart';
import 'package:hun_app/auth/user_repository.dart';
import 'package:hun_app/resources/Resources.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  createState() => LoginState();
}

class LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  UserRepository _user;

  // Terms of conditions
  bool _termsOfCond = false;

  void _onTOCChanged(bool value) {
    setState(() => _termsOfCond = value);
    debugPrint('[Login] Checkbox state: $value');
  }

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
      if (!this._termsOfCond) {
        debugPrint('[Login] User has not accepted TOC: $_termsOfCond');
        return acceptTOC(context: _context);
      }

      try {
        bool success = await this._user.signIn(_email, _password);
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AuthAnimation()),
          ).then((_) {
            if (!success)
              showToast(
                  context: _context,
                  message: 'Verifica tus credenciales',
                  milliseconds: 1000);
          });
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  void initState() {
    debugPrint('[Login] Checkbox initial state: $_termsOfCond');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
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
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffF1F1F1),
                ),
                child: TextFormField(
                  key: !obscureText ? Key('email') : Key("password"),
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Ancízar Sans Light',
                    fontSize: MediaQuery.of(context).size.height / 39,
                    color: Color.fromRGBO(158, 158, 158, 1),
                  ),
                  decoration: InputDecoration(
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
                decoration: BoxDecoration(
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

  Widget build(BuildContext context) {
    this._user = Provider.of<UserRepository>(context);
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
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
                          spaceBetween(40),
                          Hero(tag: 'hunLogo', child: hunLogo(context)),
                          paddingTitle(context),
                          spaceBetween(20),
                          _textFormField('Usuario/Email', false),
                          spaceBetween(1),
                          _textFormField('Contraseña', true),
                          spaceBetween(10),
                          mainButton(
                            context: context,
                            buttonText: 'Iniciar Sesión',
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 2,
                            onPressed: () => this.validateAndSubmit(context),
                          ),
                          checkBoxWithURL(
                            context: context,
                            onChanged: _onTOCChanged,
                            value: _termsOfCond,
                            text: toc,
                          ),
                          Text(
                            '¿Eres un usuario nuevo?',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 39,
                              fontFamily: 'Ancízar Sans Light',
                              color: Color(0xff707070),
                            ),
                          ),
                          offTopicButton(
                            context: context,
                            buttonText: 'Registrarse',
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 2.1,
                            onPressed: () {
                              _formKey.currentState.reset();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Register(this._user),
                                ),
                              );
                            },
                          ),
                          spaceBetween(20)
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
