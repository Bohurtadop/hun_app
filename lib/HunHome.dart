import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/HunProfile.dart';

String userName = 'Cristian Veloza';
String typeUser = 'Usuario particular';
List cita1 = ["Fisioterapia", "Domingo 30 de Diciembre", "10:00 a.m."];

class HunHome extends StatefulWidget {
  @override
  createState() => new HunHomeState();
}

class HunHomeState extends State<HunHome> with TickerProviderStateMixin {
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
            fontSize: 30,
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
          width: 60,
          height: 60,
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
                    fontSize: 40,
                    fontFamily: 'Ancízar Sans Bold',
                    color: const Color(0xFF1266A4),
                  )),
              Text('Salud',
                  style: new TextStyle(
                    fontSize: 40,
                    fontFamily: 'Ancízar Sans Light',
                    color: const Color(0xFF1266A4),
                  ))
            ])),
    ]);
  }

  _userNameTypeBox() {
    return SizedBox(
      width: 250,
      height: 51,
      child: Stack(
        children: <Widget>[
          Positioned(
            width: 250,
            top: 0,
            child: Center(
              child: Text('$userName',
                  style: new TextStyle(
                      fontSize: 30,
                      color: Color(0xFF1266A4),
                      fontFamily: 'Ancízar Sans Bold')),
            ),
          ),
          Positioned(
            width: 250,
            top: 30,
            child: Center(
              child: Text('$typeUser',
                  style: new TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ancízar Sans Light',
                      color: Color(0xff9E9E9E))),
            ),
          ),
        ],
      ),
    );
  }

  _meetingContainer() {
    return Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            new BoxShadow(
                blurRadius: 5.0,
                color: new Color.fromRGBO(0, 0, 0, 0.36),
                offset: new Offset(0, 5.0)),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Colors.black12,
                  ),
                  child: Icon(
                    Icons.accessible,
                    size: 50,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${cita1[0]}',
                    style: new TextStyle(
                      color: Color(0xff1266A4),
                      fontFamily: 'Ancízar Sans Bold',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${cita1[1]}',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Ancízar Sans Light',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${cita1[2]}',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Ancízar Sans Light',
                      fontSize: 15,
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
                            size: 25,
                          ),
                          Text(
                            'Reagendar',
                            style: new TextStyle(
                                color: Color(0xff1266A4),
                                fontFamily: 'Ancízar Sans Light',
                                fontSize: 10),
                          )
                        ],
                      ),
                      onPressed: null,
                    ),
                    height: 50,
                    width: 50,
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
                            size: 25,
                          ),
                          Text(
                            'Cancelar',
                            style: new TextStyle(
                                color: Color(0xff1266A4),
                                fontFamily: 'Ancízar Sans Light',
                                fontSize: 10),
                          )
                        ],
                      ),
                      onPressed: null,
                    ),
                    height: 50,
                    width: 50,
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
            fontSize: 20,
            fontFamily: 'Ancízar Sans Light',
            color: Color(0xFF1266A4)),
      ),
    );
  }

  _bottomNavigationBar() {
    return BottomAppBar(
        shape: new AutomaticNotchedShape(RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)))),
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
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'INICIO',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Ancízar Sans Regular'),
                    ),
                  )
                ],
              ),
              height: 52,
              width: 60,
            ),
            Container(
              height: 52,
              width: 60,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HunProfile()));
                  },
                  icon: Icon(
                    Icons.account_circle,
                    size: 25,
                    color: Color.fromRGBO(255, 255, 255, 0.50),
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 52,
              width: 60,
              child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.event,
                    size: 25,
                    color: Color.fromRGBO(255, 255, 255, 0.50),
                  )),
            ),
            Container(
                height: 52,
                width: 60,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.search,
                    size: 25,
                    color: Color.fromRGBO(255, 255, 255, 0.50),
                  ),
                )),
          ],
        ));
  }

  _floatingActionButton() {
    return FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context);
        },
        child: Icon(
          Icons.add,
          size: 40,
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
            _spaceBetween(40),
            _hunLogoAndTittle(),
            _spaceBetween(30),
            _userNameTypeBox(),
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
