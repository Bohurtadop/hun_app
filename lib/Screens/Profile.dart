import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/auth/user_repository.dart';
import 'package:hun_app/models/UserInfo.dart';
import 'package:hun_app/resources/Resources.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final String uid;

  Profile({@required this.uid});

  @override
  createState() => ProfileState();
}

class ProfileState extends State<Profile> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  _profilePhoto() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      height: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.26),
            offset: Offset(5.0, 5.0),
          ),
        ],
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/ProfileImage.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    spaceBetween(40),
                    hunLogoAndTittle(context),
                    _profilePhoto(),
                    UserInfo(uid: widget.uid),
                    spaceBetween(10),
                    mainButton(
                      context: context,
                      buttonText: "Editar datos",
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    spaceBetween(5),
                    mainButton(
                      context: context,
                      buttonText: "Mi historia clínica",
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    spaceBetween(10),
                    offTopicButton(
                      context: context,
                      buttonText: "Cerrar sesión",
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width / 2.1,
                      onPressed: () =>
                          Provider.of<UserRepository>(context).signOut(),
                    ),
                    spaceBetween(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
