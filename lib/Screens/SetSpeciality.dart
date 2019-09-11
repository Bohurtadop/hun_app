import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/models/Specialties.dart';
import 'package:hun_app/resources/Resources.dart';

class SetSpeciality extends StatefulWidget {
  SetSpeciality();

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child: Specialties(),
      ),
      appBar: appBar(
        context: context,
        text: 'Seleccione la especialidad',
        asset: 'assets/images/HunLogo2.png',
        color: Colors.white.value
      ),
      floatingActionButton: floatingActionButton(
        context: context,
        icon: Icons.close,
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
