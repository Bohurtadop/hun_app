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

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(
        Icons.close,
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
              height: MediaQuery.of(context).size.width / 7),
          child: Text(
            'Seleccione especialidad',
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
        child: Specialties(),
      ),
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
