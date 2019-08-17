import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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

  _hunLogoAndTittle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'hunLogo',
          child: Container(
            width: MediaQuery.of(context).size.width / 8,
            height: MediaQuery.of(context).size.width / 8,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/HunLogo2.png'),
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
                  color: Color(0xff74BEE7),
                ),
              ),
              Text(
                'Salud',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 9,
                  fontFamily: 'Ancízar Sans Light',
                  color: Color(0xff74BEE7),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
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
      title: _hunLogoAndTittle(),
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

  Future<Widget> _container(String rute) async {
    return Future.value(
      Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(rute),
          ),
        ),
      ),
    );
  }

  _specialityContainer(String rute, String description) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width / 18),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Color.fromRGBO(0, 0, 0, 0.36),
              offset: Offset(0, 5.0),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width / 28,
            left: MediaQuery.of(context).size.width / 150,
            right: MediaQuery.of(context).size.width / 150,
            top: MediaQuery.of(context).size.width / 28,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                child: FutureBuilder(
                  future: _container(rute),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data;
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 14,
                    fontFamily: 'Ancízar Sans Regular',
                    color: const Color(0xFF1266A4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Dermatology.png', "Dermatología"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Pediatrics.png', "Pediatría"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Allergology.png', "Alergología"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Anesthesiology.png', "Anestesiología"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Non-invasive cardiology.png',
                "Cardiología no invasiva"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Cardiovascular surgery.png',
                "Cirugía cardiovascular"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Head and neck surgery.png',
                "Cirugía de cabeza y cuello"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Hand surgery.png', "Cirugía de mano"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/General surgery.png', "Cirugía general"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Maxillofacial surgery.png',
                "Cirugía maxilofacial"),
            _spaceBetween(20),
            _specialityContainer(
                'assets/specialities/Peripheral vascular surgery.png',
                "Cirugía vascular periférica"),
            _spaceBetween(20)
          ],
        ),
      ),
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
