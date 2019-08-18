import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/models/Appointments.dart';
import 'package:hun_app/models/UserInfo.dart';
import 'package:hun_app/resources/Resources.dart';

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
            spaceBetween(50),
            hunLogoAndTittle(context),
            spaceBetween(30),
            UserInfo(uid: widget.uid),
            darkTitle(title: 'PRÓXIMAS CITAS', context: context),
            ActiveAppointments(uid: widget.uid),
            _endText(),
            spaceBetween(20)
          ],
        ),
      ),
    );
  }
}
