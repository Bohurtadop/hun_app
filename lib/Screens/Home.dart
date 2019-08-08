import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/Screens/Profile.dart';
import 'package:hun_app/Screens/SetSpeciality.dart';
import 'package:hun_app/models/UserInfo.dart';

String userName = 'Cristian Veloza';
String typeUser = 'Usuario particular';
List cita1 = ["Fisioterapia", "Domingo 30 de Diciembre", "10:00 a.m."];

class Home extends StatefulWidget {
  final String uid;
  Home(this.uid);

  @override
  createState() => new HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _darkTittle(String tittle) {
    return Padding(
      padding: EdgeInsets.all(20),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'hunLogo',
          child: Container(
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.width / 7,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/HunLogo1.png'),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Text('HUN',
                  style: new TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 9,
                    fontFamily: 'Ancízar Sans Bold',
                    color: const Color(0xFF1266A4),
                  )),
              Text(
                'Salud',
                style: new TextStyle(
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

  _userNameTypeBox() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.width / 5,
      child: Stack(
        children: <Widget>[
          Positioned(
            width: MediaQuery.of(context).size.width / 1.5,
            top: 0,
            child: Center(
              child: Text(
                '$userName',
                style: new TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 10,
                    color: Color(0xFF1266A4),
                    fontFamily: 'Ancízar Sans Bold'),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width / 1.5,
            top: MediaQuery.of(context).size.width / 9,
            child: Center(
              child: Text(
                '$typeUser',
                style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  fontFamily: 'Ancízar Sans Light',
                  color: Color(0xff9E9E9E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _meetingContainer() {
    return Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width / 18)),
          boxShadow: [
            new BoxShadow(
                blurRadius: 5.0,
                color: new Color.fromRGBO(0, 0, 0, 0.36),
                offset: new Offset(0, 5.0)),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.width / 18,
              left: MediaQuery.of(context).size.width / 150,
              right: MediaQuery.of(context).size.width / 150,
              top: MediaQuery.of(context).size.width / 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.width / 20),
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.width / 20),
                      topLeft: Radius.circular(
                          MediaQuery.of(context).size.width / 20),
                      topRight: Radius.circular(
                          MediaQuery.of(context).size.width / 20),
                    ),
                    color: Colors.black12,
                  ),
                  child: Icon(
                    Icons.accessible,
                    size: MediaQuery.of(context).size.width / 7,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${cita1[0]}',
                    style: new TextStyle(
                      color: Color(0xff1266A4),
                      fontFamily: 'Ancízar Sans Bold',
                      fontSize: MediaQuery.of(context).size.width / 18,
                    ),
                  ),
                  Text(
                    '${cita1[1]}',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Ancízar Sans Light',
                      fontSize: MediaQuery.of(context).size.width / 20,
                    ),
                  ),
                  Text(
                    '${cita1[2]}',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Ancízar Sans Light',
                      fontSize: MediaQuery.of(context).size.width / 20,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      disabledColor: Colors.white,
                      padding: EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.event,
                            color: Color(0xff1266A4),
                            size: MediaQuery.of(context).size.width / 12,
                          ),
                          Text(
                            'Reagendar',
                            style: new TextStyle(
                                color: Color(0xff1266A4),
                                fontFamily: 'Ancízar Sans Light',
                                fontSize:
                                    MediaQuery.of(context).size.width / 29),
                          )
                        ],
                      ),
                      onPressed: null,
                    ),
                    height: MediaQuery.of(context).size.width / 7,
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                  Container(
                    child: RaisedButton(
                      disabledColor: Colors.white,
                      padding: EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.cancel,
                            color: Color(0xff1266A4),
                            size: MediaQuery.of(context).size.width / 12,
                          ),
                          Text(
                            'Cancelar',
                            style: new TextStyle(
                                color: Color(0xff1266A4),
                                fontFamily: 'Ancízar Sans Light',
                                fontSize:
                                    MediaQuery.of(context).size.width / 29),
                          )
                        ],
                      ),
                      onPressed: null,
                    ),
                    height: MediaQuery.of(context).size.width / 8,
                    width: MediaQuery.of(context).size.width / 8,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  _endText() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Text(
        'Usted no tiene más citas agendadas.',
        style: new TextStyle(
            fontSize: MediaQuery.of(context).size.width / 18,
            fontFamily: 'Ancízar Sans Light',
            color: Color(0xFF1266A4)),
      ),
    );
  }

  _bottomNavigationBar() {
    return BottomAppBar(
      shape: new AutomaticNotchedShape(RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(MediaQuery.of(context).size.width / 18),
              topLeft:
                  Radius.circular(MediaQuery.of(context).size.width / 18)))),
      color: Color(0xff1266A4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width / 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'INICIO',
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 28,
                        fontFamily: 'Ancízar Sans Regular'),
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.width / 7,
            width: MediaQuery.of(context).size.width / 6,
          ),
          Container(
            height: MediaQuery.of(context).size.width / 7,
            width: MediaQuery.of(context).size.width / 6,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Profile(widget.uid)));
                },
                icon: Icon(
                  Icons.account_circle,
                  size: MediaQuery.of(context).size.width / 14,
                  color: Color.fromRGBO(255, 255, 255, 0.50),
                )),
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
            builder: (BuildContext context) => SetSpeciality(widget.uid),
          ),
        );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _spaceBetween(50),
            _hunLogoAndTittle(),
            _spaceBetween(30),
            _userNameTypeBox(),
            new UserInfo(uid: widget.uid),
            _darkTittle('PRÓXIMAS CITAS'),
            _meetingContainer(),
            _spaceBetween(20),
            _meetingContainer(),
            _spaceBetween(20),
            _meetingContainer(),
            _spaceBetween(20),
            _meetingContainer(),
            _spaceBetween(20),
            _meetingContainer(),
            _endText(),
            _spaceBetween(20)
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
