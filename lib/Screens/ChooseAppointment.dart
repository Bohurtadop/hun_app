import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/models/Appointments.dart';

import 'package:hun_app/resources/Resources.dart';

class ChooseAppointment extends StatefulWidget {
  final String uid;
  final String specialty;
  ChooseAppointment({@required this.uid, @required this.specialty});
  @override
  createState() => ChooseAppointmentState();
}

class ChooseAppointmentState extends State<ChooseAppointment>
    with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(
        Icons.arrow_back,
        size: MediaQuery.of(context).size.width / 12,
      ),
    );
  }

  _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff1266A4),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 18),
          bottomRight: Radius.circular(MediaQuery.of(context).size.width / 18),
        ),
      ),
      title: hunLogoAndTittle(context),
      bottom: PreferredSize(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.width / 7,
          ),
          child: Text(
            'Seleccione la cita deseada',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 16,
                color: Colors.white,
                fontFamily: 'Ancízar Sans Bold'),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width / 7,
            MediaQuery.of(context).size.width / 7),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child: AvailableAppointments(uid: widget.uid, specialty: widget.specialty),
      ),
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
