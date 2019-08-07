import 'package:cloud_firestore/cloud_firestore.dart';
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
          //TODO: Loading widget
            return new Text('Loading...');
            break;
          default:
            if (snapshot.hasData) {
              DocumentSnapshot userDocument = snapshot.data;
              //TODO: Show user's name and type of user
              return Text(userDocument['uid']);
            } else {
              return Text('Document has no info');
            }
        }
      },
    );
  }
}
