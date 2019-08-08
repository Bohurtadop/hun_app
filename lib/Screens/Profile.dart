import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/Screens/Home.dart';
import 'package:hun_app/Screens/SetSpeciality.dart';
import 'package:hun_app/auth/auth.dart';
import 'package:hun_app/auth/auth_provider.dart';
import 'package:hun_app/auth/root_page.dart';
import 'package:hun_app/models/UserInfo.dart';


class Profile extends StatefulWidget {
  final String uid;
  Profile(this.uid);
  @override
  createState() => new ProfileState();
}

class ProfileState extends State<Profile> with TickerProviderStateMixin {
  Future<void> _signOut() async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      setState(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => RootPage()),
          (_) => false,
        );
      });
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
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Hero(
        tag: 'hunLogo',
        child: Container(
          width: MediaQuery.of(context).size.width / 7,
          height: MediaQuery.of(context).size.width / 7,
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
                  fontSize: MediaQuery.of(context).size.width / 9,
                  fontFamily: 'Ancízar Sans Bold',
                  color: const Color(0xFF1266A4),
                )),
            Text('Salud',
                style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 9,
                  fontFamily: 'Ancízar Sans Light',
                  color: const Color(0xFF1266A4),
                ))
          ])),
    ]);
  }

  _profilePhoto() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      height: MediaQuery.of(context).size.width / 2.2,
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
              blurRadius: 5,
              color: new Color.fromRGBO(0, 0, 0, 0.26),
              offset: new Offset(5.0, 5.0)),
        ],
        shape: BoxShape.circle,
        image: new DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/ProfileImage.png')),
      ),
    );
  }

  _mainButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context);
        },
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

  _offTopicButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: this._signOut,
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

  _bottomNavigationBar() {
    return BottomAppBar(
      shape: new AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(MediaQuery.of(context).size.width / 18),
            topLeft: Radius.circular(MediaQuery.of(context).size.width / 18),
          ),
        ),
      ),
      color: Color(0xff1266A4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 7,
            width: MediaQuery.of(context).size.width / 6,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Home(widget.uid),
                  ),
                );
              },
              icon: Icon(
                Icons.home,
                size: MediaQuery.of(context).size.width / 14,
                color: Color.fromRGBO(255, 255, 255, 0.50),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width / 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'PERFIL',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 28,
                      fontFamily: 'Ancízar Sans Regular',
                    ),
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.width / 7,
            width: MediaQuery.of(context).size.width / 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 16,
          ),
          Container(
            height: MediaQuery.of(context).size.width / 7,
            width: MediaQuery.of(context).size.width / 6,
            child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.event,
                  size: MediaQuery.of(context).size.width / 14,
                  color: Color.fromRGBO(255, 255, 255, 0.50),
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.width / 7,
            width: MediaQuery.of(context).size.width / 6,
            child: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
                size: MediaQuery.of(context).size.width / 14,
                color: Color.fromRGBO(255, 255, 255, 0.50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SetSpeciality(widget.uid)));
      },
      child: Icon(
        Icons.add,
        size: MediaQuery.of(context).size.width / 12,
      ),
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
            new UserInfo(uid: widget.uid),
            _spaceBetween(10),
            _mainButton("Editar datos", MediaQuery.of(context).size.height / 16,
                MediaQuery.of(context).size.width / 2),
            _spaceBetween(5),
            _mainButton(
                "Mi historia clínica",
                MediaQuery.of(context).size.height / 16,
                MediaQuery.of(context).size.width / 2),
            _spaceBetween(10),
            _offTopicButton(
                "Cerrar sesión",
                MediaQuery.of(context).size.height / 16,
                MediaQuery.of(context).size.width / 2.1),
            _spaceBetween(20),
          ],
        ),
      )),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
