import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// This class creates a widget with all active appointments.
class ActiveAppointments extends StatelessWidget {
  const ActiveAppointments({@required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collectionGroup('appointments')
          .where('client', isEqualTo: this.uid)
          .where('state', isGreaterThanOrEqualTo: 1)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (!snapshot.hasData) {
              return Text('No se pudieron obtener tus citas');
            }

            debugPrint('********\nAppointments:\n+++++++');

            // we save the appointments' widgets in a list
            List<Container> appointments = snapshot.data.documents.map(
              (DocumentSnapshot document) {
                String appointmentType = document['type'];
                DateTime dateStart = document['start'].toDate();
                DateTime dateEnd = document['end'].toDate();

                debugPrint('Type: $appointmentType');
                debugPrint('Doctor\'s id: ${document['doctor']}');
                debugPrint('State: ${document['state']}');
                debugPrint('Start: ${dateStart.toString()}}');
                debugPrint('End: ${dateEnd.toString()}}');
                debugPrint('+++++++');

                return Container(
                  child: AppointmentWidget(
                    type: appointmentType,
                    dateStart: dateStart,
                    dateEnd: dateEnd,
                  ),
                );
              },
            ).toList();

            int length = appointments.length - 1;

            debugPrint('appointments.length: $length');

            // We add spaces between appointments
            for (var i = 0; i < length; i++) {
              debugPrint('Index: ${2 * i + 1}');
              appointments.insert(
                2 * i + 1,
                Container(child: SizedBox(height: 20)),
              );
            }

            debugPrint('appointments.length: ${appointments.length}\n--------');

            return Column(children: appointments);
        }
      },
    );
  }
}

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({
    Key key,
    @required this.type,
    @required this.dateStart,
    @required this.dateEnd,
  }) : super(key: key);

  final String type;
  final DateTime dateStart;
  final DateTime dateEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          bottom: MediaQuery.of(context).size.width / 18,
          left: MediaQuery.of(context).size.width / 150,
          right: MediaQuery.of(context).size.width / 150,
          top: MediaQuery.of(context).size.width / 18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    MediaQuery.of(context).size.width / 20,
                  ),
                  bottomRight: Radius.circular(
                    MediaQuery.of(context).size.width / 20,
                  ),
                  topLeft: Radius.circular(
                    MediaQuery.of(context).size.width / 20,
                  ),
                  topRight: Radius.circular(
                    MediaQuery.of(context).size.width / 20,
                  ),
                ),
                color: Colors.black12,
              ),
              child: Icon(
                Icons.accessible,
                size: MediaQuery.of(context).size.width / 7,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // we display the appointment type
                Text(
                  type,
                  style: TextStyle(
                    color: Color(0xff1266A4),
                    fontFamily: 'Ancízar Sans Bold',
                    fontSize: MediaQuery.of(context).size.width / 18,
                  ),
                ),
                // we display where it starts the appointment
                Text(
                  dateStart.toString(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Ancízar Sans Light',
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                ),
                // we display where it ends the appointment
                Text(
                  dateEnd.toString(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Ancízar Sans Light',
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    disabledColor: Colors.white,
                    padding: EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.event,
                          color: Color(0xff1266A4),
                          size: MediaQuery.of(context).size.width / 12,
                        ),
                        Text(
                          'Reagendar',
                          style: TextStyle(
                            color: Color(0xff1266A4),
                            fontFamily: 'Ancízar Sans Light',
                            fontSize: MediaQuery.of(context).size.width / 29,
                          ),
                        )
                      ],
                    ),
                    onPressed: null,
                  ),
                  height: MediaQuery.of(context).size.width / 7,
                  width: MediaQuery.of(context).size.width / 7,
                ),
                Container(
                  child: RaisedButton(
                    disabledColor: Colors.white,
                    padding: EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.cancel,
                          color: Color(0xff1266A4),
                          size: MediaQuery.of(context).size.width / 12,
                        ),
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Color(0xff1266A4),
                            fontFamily: 'Ancízar Sans Light',
                            fontSize: MediaQuery.of(context).size.width / 29,
                          ),
                        )
                      ],
                    ),
                    onPressed: null,
                  ),
                  height: MediaQuery.of(context).size.width / 8,
                  width: MediaQuery.of(context).size.width / 8,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
