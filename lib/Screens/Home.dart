import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/models/Appointments.dart';
import 'package:hun_app/models/UserInfo.dart';

List cita1 = ["Fisioterapia", "Domingo 30 de Diciembre", "10:00 a.m."];

class Home extends StatefulWidget {
  final String uid;
  Home({@required this.uid});

  @override
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _darkTittle(String tittle) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        tittle,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 12,
          fontFamily: 'Ancízar Sans Bold',
          color: Color(0xff707070),
        ),
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
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
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
              Text(
                'HUN',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 9,
                  fontFamily: 'Ancízar Sans Bold',
                  color: const Color(0xFF1266A4),
                ),
              ),
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

  _endText() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Text(
        'Usted no tiene más citas agendadas.',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 18,
          fontFamily: 'Ancízar Sans Light',
          color: Color(0xFF1266A4),
        ),
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
            UserInfo(uid: widget.uid),
            _darkTittle('PRÓXIMAS CITAS'),
            ActiveAppointments(uid: widget.uid),
            _endText(),
            _spaceBetween(20)
          ],
        ),
      ),
    );
  }
}
