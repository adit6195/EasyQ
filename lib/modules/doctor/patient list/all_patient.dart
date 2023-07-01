import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../models/appointment_model.dart';
import '../../../widget.dart';

class AllPatientScreen extends StatefulWidget {
  String doctor;
  AllPatientScreen({required this.doctor});

  @override
  State<AllPatientScreen> createState() => _AllPatientScreenState();
}

class _AllPatientScreenState extends State<AllPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: Colors.purple[800],
          title:const Text("All Patient"),
          
        ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                Text("text" + widget.doctor, style: TextStyle(fontSize: 50)),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Appointments")
                      .where("doctor_name", isEqualTo: widget.doctor)
                      // .where("status", isEqualTo: "doctor room")
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
                                snapshot.data!.docs[index]),"",context);
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
    );
  }
}