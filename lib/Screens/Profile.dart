import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/auth/auth.dart';
import 'package:hun_app/auth/auth_provider.dart';
import 'package:hun_app/auth/root_page.dart';
import 'package:hun_app/models/UserInfo.dart';
import 'package:hun_app/resources/Resources.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({@required this.uid});
  @override
  createState() => ProfileState();
}

class ProfileState extends State<Profile> with TickerProviderStateMixin {
  Future<void> _signOut() async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      setState(
        () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => RootPage()),
          (_) => false,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
  }

  _hunLogoAndTittle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'hunLogo',
          child: Container(
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.width / 7,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/HunLogo1.png')),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Text('HUN',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 9,
                    fontFamily: 'Ancízar Sans Bold',
                    color: const Color(0xFF1266A4),
                  )),
              Text(
                'Salud',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 9,
                  fontFamily: 'Ancízar Sans Light',
                  color: const Color(0xFF1266A4),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _profilePhoto() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      height: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.26),
            offset: Offset(5.0, 5.0),
          ),
        ],
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/ProfileImage.png'),
        ),
      ),
    );
  }

  _mainButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: () => showUnavailableMessage(context),
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
        onPressed: this._signOut,
        color: Color(0xFF1266A4),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height / 35),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _spaceBetween(40),
              _hunLogoAndTittle(),
              _profilePhoto(),
              UserInfo(uid: widget.uid),
              _spaceBetween(10),
              _mainButton(
                "Editar datos",
                MediaQuery.of(context).size.height / 16,
                MediaQuery.of(context).size.width / 2,
              ),
              _spaceBetween(5),
              _mainButton(
                "Mi historia clínica",
                MediaQuery.of(context).size.height / 16,
                MediaQuery.of(context).size.width / 2,
              ),
              _spaceBetween(10),
              _offTopicButton(
                "Cerrar sesión",
                MediaQuery.of(context).size.height / 16,
                MediaQuery.of(context).size.width / 2.1,
              ),
              _spaceBetween(20),
            ],
          ),
        ),
      ),
    );
  }
}
