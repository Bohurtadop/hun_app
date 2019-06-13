import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/Screens/Home.dart';

class HunCalendar extends StatefulWidget {
  @override
  createState() => new HunCalendarState();
}

class HunCalendarState extends State<HunCalendar> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _spaceBetween(double space) {
    return SizedBox(
      height: space,
    );
  }

  _hunLogoAndTittle() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Hero(
        tag: 'hunLogo',
        child: Container(
          width: 60,
          height: 60,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/HunLogo1.png')),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.all(5),
          child: Row(children: <Widget>[
            Text('HUN',
                style: new TextStyle(
                  fontSize: 40,
                  fontFamily: 'Ancízar Sans Bold',
                  color: const Color(0xFF1266A4),
                )),
            Text('Salud',
                style: new TextStyle(
                  fontSize: 40,
                  fontFamily: 'Ancízar Sans Light',
                  color: const Color(0xFF1266A4),
                ))
          ])),
    ]);
  }

  _profilePhoto() {
    return Container(
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
    );
  }

  _userNameTypeBox() {
    return SizedBox(
      width: 250,
      height: 51,
      child: Stack(
        children: <Widget>[
          Positioned(
            width: 250,
            top: 0,
            child: Center(
              child: Text('$userName',
                  style: new TextStyle(
                      fontSize: 30,
                      color: Color(0xFF1266A4),
                      fontFamily: 'Ancízar Sans Bold')),
            ),
          ),
          Positioned(
            width: 250,
            top: 30,
            child: Center(
              child: Text('$typeUser',
                  style: new TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ancízar Sans Light',
                      color: Color(0xff9E9E9E))),
            ),
          ),
        ],
      ),
    );
  }

  _mainButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context);
        },
        color: Color(0xffFF8800),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      height: height,
      width: width,
    );
  }

  _offTopicButton(String buttonText, double height, double width) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          Navigator.of(context);
        },
        color: Color(0xFF1266A4),
        elevation: 5,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      height: height,
      width: width,
    );
  }

  _bottomNavigationBar() {
    return BottomAppBar(
        shape: new AutomaticNotchedShape(RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)))),
        color: Color(0xff1266A4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 52,
              width: 60,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home()));
                  },
                  icon: Icon(
                    Icons.home,
                    size: 25,
                    color: Color.fromRGBO(255, 255, 255, 0.50),
                  )),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'PERFIL',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Ancízar Sans Regular'),
                    ),
                  )
                ],
              ),
              height: 52,
              width: 60,
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
        ));
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.of(context);
      },
      child: Icon(
        Icons.add,
        size: 40,
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
            _spaceBetween(40),
            _hunLogoAndTittle(),
            _profilePhoto(),
            _userNameTypeBox(),
            _spaceBetween(15),
            _mainButton("Editar datos", 40, 200),
            _spaceBetween(10),
            _mainButton("Mi historia clínica", 40, 200),
            _spaceBetween(15),
            _offTopicButton("Cerrar sesión", 30, 200),
            _spaceBetween(15),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
