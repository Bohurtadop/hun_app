import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hun_app/resources/Resources.dart';

enum AppointmentState { available, reserved }

// This class creates a widget with all active appointments.
class PendingAppointments extends StatelessWidget {
  const PendingAppointments({@required this.uid});
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
              return Text('No se pudieron obtener sus citas');
            }

            debugPrint('--------\nAppointments:\n\n+++++++');

            // we save the appointments' widgets in a list
            List<Container> appointments = snapshot.data.documents.map(
              (DocumentSnapshot document) {
                AppointmentState state =
                    AppointmentState.values[document['state']];
                String appointmentType = document['type'];
                DateTime dateStart = document['start'].toDate();
                DateTime dateEnd = document['end'].toDate();

                debugPrint('Appointment id: ${document.documentID}');
                debugPrint('Type: $appointmentType');
                debugPrint('Doctor\'s id: ${document['doctor']}');
                debugPrint('State: ${state.toString()}');
                debugPrint('Start: ${dateStart.toString()}');
                debugPrint('End: ${dateEnd.toString()}');
                debugPrint('+++++++\n');

                return Container(
                  child: AppointmentWidget(
                    key: Key(document.documentID),
                    type: appointmentType,
                    dateStart: dateStart,
                    dateEnd: dateEnd,
                    state: state,
                  ),
                );
              },
            ).toList();

            int length = appointments.length - 1;

            debugPrint('Active appointment(s): ${length + 1}');
            debugPrint('Space(s) to be inserted: $length');

            // We add spaces between appointments
            for (var i = 0; i < length; i++) {
              appointments.insert(
                2 * i + 1,
                Container(child: spaceBetween(20)),
              );
              debugPrint('\nSpace inserted at: ${2 * i + 1}');
            }

            debugPrint(
                '\nWidgets to be displayed: ${appointments.length}\n--------\n');

            return Column(children: appointments);
        }
      },
    );
  }
}

class AvailableAppointments extends StatelessWidget {
  final String uid;
  final String specialty;
  const AvailableAppointments(
      {Key key, @required this.uid, @required this.specialty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('/specialties/$specialty/appointments')
          .where('state', isEqualTo: 0)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.data.documents.length == 0 || !snapshot.hasData) {
              return Text(
                'No hay citas disponibles',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 18,
                  fontFamily: 'Ancízar Sans Light',
                  color: Color(0xFF1266A4),
                ),
              );
            }
            debugPrint('--------\nAvailable appointments:\n\n+++++++');

            // we save the appointments' widgets in a list
            List<Container> appointments = snapshot.data.documents.map(
              (DocumentSnapshot document) {
                AppointmentState state =
                    AppointmentState.values[document['state']];
                String appointmentType = document['type'];
                DateTime dateStart = document['start'].toDate();
                DateTime dateEnd = document['end'].toDate();
                String doctorName = document['doctor_name'];

                const int max_length = 23;

                // we limit the amount of character of the doctor's name (avoid out bounds)
                if (doctorName.length > max_length) {
                  List<String> subNames = doctorName.split(' ');
                  doctorName = '';
                  for (var str in subNames) {
                    doctorName = doctorName.length + str.length > max_length
                        ? doctorName
                        : doctorName.isEmpty ? str : '$doctorName $str';
                  }
                }

                debugPrint('Appointment id: ${document.documentID}');
                debugPrint('Type: $appointmentType');
                debugPrint('Doctor\'s id: ${document['doctor']}');
                debugPrint('Doctor\'s name: $doctorName');
                debugPrint('State: ${state.toString()}');
                debugPrint('Start: ${dateStart.toString()}');
                debugPrint('End: ${dateEnd.toString()}');
                debugPrint('+++++++\n');

                return Container(
                  child: AppointmentWidget(
                    key: Key(document.documentID),
                    doctorName: doctorName,
                    actionName: 'Reservar',
                    iconAction: Icons.add,
                    type: appointmentType,
                    dateStart: dateStart,
                    showDoctor: true,
                    dateEnd: dateEnd,
                    state: state,
                    onPressed: () async {
                      debugPrint(
                          '\n\n[Assign appointment] Before progress indicator');
                      CircularProgressIndicator();

                      var parameters = {
                        'specialty': specialty,
                        'appointment': document.documentID
                      };

                      debugPrint(
                          '[Assign appointment] Before calling the firebase function "assign_appointment" with parameters $parameters');
                      await CloudFunctions.instance
                          .getHttpsCallable(functionName: 'assign_appointment')
                          .call(parameters)
                          .then((HttpsCallableResult value) {
                        //Value returned
                        debugPrint('[Assign appointment] Value: ${value.data}');

                        debugPrint('[Assign appointment] Before pop() twice');
                        // we go to home page
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();

                        debugPrint('[Assign appointment] Success \n\n');
                      }).catchError((error) {
                        debugPrint('[Assign appointment] Error: $error \n\n');
                      });
                    },
                  ),
                );
              },
            ).toList();

            int length = appointments.length + 1;

            debugPrint('Specialties: ${length - 1}');
            debugPrint('Space(s) to be inserted: $length');

            // We add spaces between appointments
            for (var i = 0; i < length; i++) {
              appointments.insert(
                2 * i,
                Container(child: spaceBetween(20)),
              );
              debugPrint('\nSpace inserted at: ${2 * i}');
            }

            debugPrint(
                '\nWidgets to be displayed: ${appointments.length}\n--------\n');

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: appointments,
            );
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
    this.onPressed,
    this.doctorName,
    this.showDoctor = false,
    this.actionName = 'Cancelar',
    this.iconAction = Icons.cancel,
    this.state = AppointmentState.reserved,
  }) : super(key: key);

  final String type;
  final bool showDoctor;
  final String doctorName;
  final DateTime dateStart;
  final DateTime dateEnd;

  // Action methods
  final String actionName;
  final IconData iconAction;
  final void Function() onPressed;

  // TODO: show the state of the appointment
  final AppointmentState state;

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
                if (this.showDoctor)
                  Text(
                    this.doctorName,
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
            Container(
              child: RaisedButton(
                disabledColor: Colors.white,
                color: Colors.white,
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      this.iconAction,
                      color: Color(0xff1266A4),
                      size: MediaQuery.of(context).size.width / 12,
                    ),
                    Text(
                      this.actionName,
                      style: TextStyle(
                        color: Color(0xff1266A4),
                        fontFamily: 'Ancízar Sans Light',
                        fontSize: MediaQuery.of(context).size.width / 29,
                      ),
                    )
                  ],
                ),
                onPressed:
                    this.onPressed ?? () => showUnavailableMessage(context),
              ),
              height: MediaQuery.of(context).size.width / 8,
              width: MediaQuery.of(context).size.width / 8,
            )
          ],
        ),
      ),
    );
  }
}
