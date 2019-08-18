import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hun_app/resources/Resources.dart';

class Specialties extends StatelessWidget {
  const Specialties({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('specialties').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (!snapshot.hasData) {
              return Text('No se pudieron obtener las especialidades');
            }

            debugPrint('--------\nSpecialties:\n\n+++++++');

            List<Container> specialties =
                snapshot.data.documents.map((DocumentSnapshot document) {
              String name = document['name'];
              String assetRoute = document['assetRoute'];

              debugPrint('Specialty id: ${document.documentID}');
              debugPrint('Specitalty name: $name');
              debugPrint('Specitalty assetRoute: $assetRoute');
              debugPrint('+++++++\n');

              return Container(
                child: SpecialtyWidget(
                  key: Key(document.documentID),
                  name: name,
                  assetRute: assetRoute,
                ),
              );
            }).toList();

            int length = specialties.length + 1;

            debugPrint('Specialties: ${length - 1}');
            debugPrint('Space(s) to be inserted: $length');

            // We add spaces between appointments
            for (var i = 0; i < length; i++) {
              specialties.insert(
                2 * i,
                Container(child: spaceBetween(20)),
              );
              debugPrint('\nSpace inserted at: ${2 * i}');
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: specialties,
            );
        }
      },
    );
  }
}

class SpecialtyWidget extends StatelessWidget {
  const SpecialtyWidget(
      {Key key, @required this.name, @required this.assetRute, this.onTap})
      : super(key: key);
  final String name;
  final String assetRute;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap ??
          () {
            if (kDebugMode) debugPrint('[Specialty widget] Tapped with key: ${key.toString()}}');
            Navigator.pop(context);
          },
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
                  future: Future.value(
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(this.assetRute),
                        ),
                      ),
                    ),
                  ),
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
                  this.name,
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
}
