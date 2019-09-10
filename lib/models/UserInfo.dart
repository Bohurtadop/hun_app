import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hun_app/auth/user_repository.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({this.birthday = false});
  final bool birthday;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(Provider.of<UserRepository>(context).user.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
            break;
          default:
            if (!snapshot.hasData) {
              return Text('Document has no info');
            }
            DocumentSnapshot userDocument = snapshot.data;
            String name = userDocument['displayName'];

            initializeDateFormatting();
            var date = new DateFormat.yMMMEd('es');
            DateTime birthday = userDocument['birthday'].toDate();

            var type = userDocument['type'];

            String userType;
            if (type['admin']) {
              userType = 'Administrador';
            } else if (type['doctor']) {
              userType = 'Doctor';
            } else {
              userType = 'Usuario particular';
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 5,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: MediaQuery.of(context).size.width / 1.5,
                    top: 0,
                    child: Center(
                      child: Text(
                        name,
                        style: new TextStyle(
                          fontSize: name.length > 10
                              ? MediaQuery.of(context).size.width / name.length
                              : MediaQuery.of(context).size.width / 10,
                          color: Color(0xFF1266A4),
                          fontFamily: 'Ancízar Sans Bold',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width / 1.5,
                    top: MediaQuery.of(context).size.width / 15,
                    child: Center(
                      child: Text(
                        userType,
                        style: new TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontFamily: 'Ancízar Sans Light',
                          color: Color(0xff9E9E9E),
                        ),
                      ),
                    ),
                  ),
                  if (this.birthday && birthday != null)
                    Positioned(
                      width: MediaQuery.of(context).size.width / 1.5,
                      top: MediaQuery.of(context).size.width / 8,
                      child: Center(
                        child: Text(
                          date.format(birthday),
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 20,
                            fontFamily: 'Ancízar Sans Light',
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
        }
      },
    );
  }
}
