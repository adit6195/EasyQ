import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/patienttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../models/appointment_model.dart';
import '../../../widget.dart';

class CurrentPatientScreen extends StatefulWidget {
  final String doctor;
  const CurrentPatientScreen({required this.doctor});

  @override
  State<CurrentPatientScreen> createState() => _CurrentPatientScreenState();
}

class _CurrentPatientScreenState extends State<CurrentPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("text" + widget.doctor, style: TextStyle(fontSize: 50)),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Appointments")
              .where("doctor_name", isEqualTo: widget.doctor)
              .where("status", isEqualTo: "doctor room")
              // .orderBy("appointment_no")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // return text("text");
                    return AppontmentTile(model: AppointmentModel.fromFirestore(
                        snapshot.data!.docs[index]),role: "",context: context);
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}