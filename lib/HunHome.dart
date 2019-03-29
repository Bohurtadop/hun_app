import 'package:flutter/material.dart';

String userName = 'Cristian Veloza';
String typeUser = 'Usuario particular';
List cita1 = [
  "Fisioterapia",
  "Domingo 30 de Diciembre",
  "10:00 a.m.",
  "Johana Beltrán",
  "Fisioterapeuta"
];

class HunHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
            ]),
            Container(
              width: 190,
              height: 190,
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
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text('$userName',
                  style: new TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1266A4),
                      fontFamily: 'Ancizar Sans')),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text('$typeUser',
                  style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff9E9E9E))),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'PRÓXIMAS CITAS',
                textDirection: TextDirection.ltr,
                style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff707070)),
              ),
            ),
            Container(
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
                  padding:
                  EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 20),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(60),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.black12,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.accessible,
                                      size: 90,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${cita1[0]}',
                                          style: new TextStyle(
                                            color: Color(0xff1266A4),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          '${cita1[1]}',
                                          style: new TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${cita1[2]}',
                                          style: new TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                        size: 40,
                                      ),
                                      Text(
                                        'Reagendar',
                                        style: new TextStyle(
                                            color: Color(0xff1266A4),
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  onPressed: null,
                                ),
                                height: 68,
                                width: 100,
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
                                        size: 40,
                                      ),
                                      Text(
                                        'Cancelar',
                                        style: new TextStyle(
                                            color: Color(0xff1266A4),
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  onPressed: null,
                                ),
                                height: 68,
                                width: 100,
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 60,
                        right: 10,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/ProfileImage.png')),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 40,
                          right: 20,
                          child: Text(
                            '${cita1[3]}',
                            style: new TextStyle(
                              color: Color(0xff1266A4),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Positioned(
                          bottom: 25,
                          right: 20,
                          child: Text(
                            '${cita1[4]}',
                            style: new TextStyle(
                                color: Color(0xff1266A4), fontSize: 12),
                          )),
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
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
                  padding:
                  EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 20),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(60),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.black12,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.accessible_forward,
                                      size: 90,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${cita1[0]}',
                                          style: new TextStyle(
                                            color: Color(0xff1266A4),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          '${cita1[1]}',
                                          style: new TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${cita1[2]}',
                                          style: new TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                        size: 40,
                                      ),
                                      Text(
                                        'Reagendar',
                                        style: new TextStyle(
                                            color: Color(0xff1266A4),
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  onPressed: null,
                                ),
                                height: 68,
                                width: 100,
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
                                        size: 40,
                                      ),
                                      Text(
                                        'Cancelar',
                                        style: new TextStyle(
                                            color: Color(0xff1266A4),
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  onPressed: null,
                                ),
                                height: 68,
                                width: 100,
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 60,
                        right: 10,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/ProfileImage.png')),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 40,
                          right: 20,
                          child: Text(
                            '${cita1[3]}',
                            style: new TextStyle(
                              color: Color(0xff1266A4),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Positioned(
                          bottom: 25,
                          right: 20,
                          child: Text(
                            '${cita1[4]}',
                            style: new TextStyle(
                                color: Color(0xff1266A4), fontSize: 12),
                          )),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Usted no tiene más citas agendadas.',
                style: new TextStyle(fontSize: 20, color: Color(0xFF1266A4)),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: new AutomaticNotchedShape(RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15)))),
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
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'INICIO',
                        style: new TextStyle(color: Colors.white, fontSize: 12),
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
                    onPressed: null,
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
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: null,
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}