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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child:
            AvailableAppointments(uid: widget.uid, specialty: widget.specialty),
      ),
      appBar: appBar(context: context, text: 'Seleccione la cita deseada'),
      floatingActionButton: floatingActionButton(
        context: context,
        icon: Icons.arrow_back,
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
