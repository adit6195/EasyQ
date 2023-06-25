import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';

class DoctorHomePage extends StatefulWidget {
  final String doctorName;
  const DoctorHomePage(this.doctorName);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          text("text" + widget.doctorName, fontSize: 50),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Appointments")
                .where("doctor_name", isEqualTo: widget.doctorName)
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
                      return appointmenttile(AppointmentModel.fromFirestore(
                          snapshot.data!.docs[index]));
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
