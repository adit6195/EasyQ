import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../models/appointment_model.dart';
import '../../../widget.dart';

class EmergencyListScreen extends StatefulWidget {
  final String doctor;
  const EmergencyListScreen({required this.doctor});

  @override
  State<EmergencyListScreen> createState() => _EmergencyListScreenState();
}

class _EmergencyListScreenState extends State<EmergencyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("text" + widget.doctor, style: TextStyle(fontSize: 50)),
            // doctorAppointments("isEmergency"),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection("Appointments")
            //       .where("doctor_name", isEqualTo: widget.doctor)
            //       .where("isEmergency", isEqualTo: true)
            //       // .where("status",isEqualTo: "registered")
            //       .where("status",isEqualTo: "doctor room")
            //       // .where("status",isEqualTo: "waiting")
            //       // .orderBy("appointment_no")
            //       .snapshots(),
            //   builder: (context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       return ListView.builder(
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           itemCount: snapshot.data!.docs.length,
            //           itemBuilder: (context, index) {
            //             // return text("text");
            //             return appointmenttile(AppointmentModel.fromFirestore(
            //                 snapshot.data!.docs[index]),"",context);
            //           });
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //   },
            // ),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection("Appointments")
            //       .where("doctor_name", isEqualTo: widget.doctor)
            //       .where("isEmergency", isEqualTo: true)
            //       // .where("status",isEqualTo: "registered")
            //       // .where("status",isEqualTo: "doctor room")
            //       .where("status",isEqualTo: "waiting")
            //       // .orderBy("appointment_no")
            //       .snapshots(),
            //   builder: (context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       return ListView.builder(
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           itemCount: snapshot.data!.docs.length,
            //           itemBuilder: (context, index) {
            //             // return text("text");
            //             return appointmenttile(AppointmentModel.fromFirestore(
            //                 snapshot.data!.docs[index]),"",context);
            //           });
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }

}
