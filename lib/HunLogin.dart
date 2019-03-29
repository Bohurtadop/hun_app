import 'package:flutter/material.dart';
import 'HunHome.dart';

class HunLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 190,
                  height: 190,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/HunLogo1.png')),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 18,
                    ),
                    Container(
                      width: 230,
                      child: Text(
                        'Usuario/Email',
                        textAlign: TextAlign.left,
                        style:
                        TextStyle(color: Color(0xff707070), fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 36,
                  width: 248,
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 36,
                            width: 18,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                topLeft: Radius.circular(18),
                              ),
                              color: Color(0xffF1F1F1),
                            ),
                          ),
                          Container(
                            width: 210,
                            height: 36,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xffF1F1F1),
                            ),
                          ),
                          Container(
                            height: 36,
                            width: 18,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              color: Color(0xffF1F1F1),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 18,
                        width: 220,
                        bottom: -5,
                        child: TextField(
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(158, 158, 158, 1)),
                            decoration: new InputDecoration(
                                hintText: 'Usuario/Email',
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                fillColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none)))),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 18,
                    ),
                    Container(
                      width: 230,
                      child: Text(
                        'Contraseña',
                        textAlign: TextAlign.left,
                        style:
                        TextStyle(color: Color(0xff707070), fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 36,
                  width: 248,
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 36,
                            width: 18,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                topLeft: Radius.circular(18),
                              ),
                              color: Color(0xffF1F1F1),
                            ),
                          ),
                          Container(
                            width: 210,
                            height: 36,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xffF1F1F1),
                            ),
                          ),
                          Container(
                            height: 36,
                            width: 18,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              color: Color(0xffF1F1F1),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 18,
                        width: 220,
                        bottom: -5,
                        child: TextField(
                            textAlign: TextAlign.left,
                            obscureText: true,
                            style: new TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(158, 158, 158, 1)),
                            decoration: new InputDecoration(
                                hintText: 'Contraseña',
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(158, 158, 158, 1)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none)))),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: RaisedButton(
                    onPressed: null,
                    disabledColor: Color(0xffFF8800),
                    disabledTextColor: Colors.white,
                    disabledElevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  height: 46,
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '¿Es usuario nuevo?',
                  style: TextStyle(fontSize: 15, color: Color(0xff707070)),
                ),
                Container(
                  child: RaisedButton(
                    onPressed: null,
                    disabledColor: Color(0xff74BEE7),
                    disabledTextColor: Colors.white,
                    disabledElevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  height: 32,
                  width: 140,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ));
  }
}
