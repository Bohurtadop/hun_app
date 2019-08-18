import 'package:flutter/material.dart';

void showUnavailableMessage(BuildContext context) {
  showToast(context: context);
}

void showToast(
    {@required BuildContext context,
    String message = 'Aún no disponible',
    int milliseconds = 500}) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: milliseconds),
    ),
  );
}

SizedBox spaceBetween(double space) {
  return SizedBox(
    height: space,
  );
}

Row hunLogoAndTittle(BuildContext context) {
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

Padding darkTitle({String title, BuildContext context}) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Text(
      title,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width / 12,
        fontFamily: 'Ancízar Sans Bold',
        color: Color(0xff707070),
      ),
    ),
  );
}

Padding paddingTitle(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(5),
    child: Row(
      children: <Widget>[
        Text(
          'HUN',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 12,
            fontFamily: 'Ancízar Sans Bold',
            color: const Color(0xFF1266A4),
          ),
        ),
        Text(
          'Salud',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 12,
            fontFamily: 'Ancízar Sans Light',
            color: const Color(0xFF1266A4),
          ),
        )
      ],
    ),
  );
}

Container hunLogo(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.9,
    height: MediaQuery.of(context).size.width / 1.9,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage('assets/images/HunLogo1.png'),
      ),
    ),
  );
}

Container mainButton(
    {@required String buttonText,
    @required double height,
    @required double width,
    @required BuildContext context,
    void Function() onPressed}) {
  debugPrint('Button text: $buttonText');
  return Container(
    child: RaisedButton(
      onPressed: onPressed ?? () => showUnavailableMessage(context),
      color: Color(0xffFF8800),
      elevation: 5,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height / 34),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 39,
            color: Colors.white),
      ),
    ),
    height: height,
    width: width,
  );
}

Container offTopicButton(
    {@required String buttonText,
    @required double height,
    @required double width,
    @required BuildContext context,
    void Function() onPressed}) {
  return Container(
    child: RaisedButton(
      onPressed: onPressed ?? () => showUnavailableMessage(context),
      color: Color(0xFF1266A4),
      elevation: 5,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height / 35),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 39,
          color: Colors.white,
        ),
      ),
    ),
    height: height,
    width: width,
  );
}

AppBar appBar({@required BuildContext context, @required String text}) {
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
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 16,
            color: Colors.white,
            fontFamily: 'Ancízar Sans Bold',
          ),
        ),
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width / 7,
        MediaQuery.of(context).size.width / 7,
      ),
    ),
  );
}

FloatingActionButton floatingActionButton(
    {@required BuildContext context,
    @required void Function() onPressed,
    Widget child,
    IconData icon,
    Color backgroundColor}) {
  return FloatingActionButton(
    backgroundColor: backgroundColor ?? Colors.orange,
    onPressed: onPressed ?? () => showUnavailableMessage(context),
    child: child ??
        Icon(
          icon,
          size: MediaQuery.of(context).size.width / 12,
        ),
  );
}
