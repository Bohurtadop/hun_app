import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          Firestore.instance.collection('users').document(this.uid).snapshots(),
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
            if (snapshot.hasData) {
              DocumentSnapshot userDocument = snapshot.data;
              String name = userDocument['displayName'];

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
                          '$name',
                          style: new TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 10,
                              color: Color(0xFF1266A4),
                              fontFamily: 'Ancízar Sans Bold'),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width / 1.5,
                      top: MediaQuery.of(context).size.width / 9,
                      child: Center(
                        child: Text(
                          '$userType',
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontFamily: 'Ancízar Sans Light',
                            color: Color(0xff9E9E9E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('Document has no info');
            }
        }
      },
    );
  }
}
