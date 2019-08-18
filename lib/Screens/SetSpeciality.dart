import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/models/Specialties.dart';
import 'dart:async';

import 'package:hun_app/resources/Resources.dart';

class SetSpeciality extends StatefulWidget {
  final String uid;
  SetSpeciality(this.uid);
  @override
  createState() => SetSpecialityState();
}

class SetSpecialityState extends State<SetSpeciality>
    with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _time) {
      setState(() => _time = picked);
    }

    print("Time selected: ${_time.toString()}");

    Navigator.of(context).pop();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2020),
    );

    if (picked != null && picked != _date) {
      setState(() => _date = picked);
    }

    print("Date selected: ${_date.toString()}");

    _selectTime(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child: Specialties(uid: widget.uid),
      ),
      appBar: appBar(context: context, text: 'Seleccione la especialidad'),
      floatingActionButton: floatingActionButton(
        context: context,
        icon: Icons.close,
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
