import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/functions.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/models/refund_model.dart';
import 'package:easy_q/modules/registration/patient_registration_page.dart';
import 'package:easy_q/role_page.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RefundScreen extends StatefulWidget {
  // String role;
  // RefundScreen({required this.role});

  @override
  State<RefundScreen> createState() =>
      _RefundScreenState();
}

class _RefundScreenState
    extends State<RefundScreen> {
  List<String> allDoctors = [];
  String doctor = "";

  void getDoctorsList() {
    FirebaseFirestore.instance
        .collection("doctors")
        .orderBy("doctor_name")
        .get()
        .then((value) => {
              for (var i = 0; i < value.docs.length; i++)
                {
                  setState(() {
                    allDoctors.add(value.docs[i]["doctor_name"]);
                  })
                },
              if (value.docs.length > 0)
                {
                  setState(() {
                    doctor = value.docs[0]["doctor_name"];
                  })
                },
              print(value.docs.length),
              print("All Doctors" + allDoctors[0]),
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorsList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: allDoctors.length,
      child: Scaffold(
          // floatingActionButton:widget.role=="Registration" ? FloatingActionButton(
          //   backgroundColor: Colors.deepPurple,
          //     child: Icon(Icons.person_add_alt_1),
          //     onPressed: () {
          //       navigateslide(PatientRegistrationPage(), context);
          //     }):null,
          appBar: AppBar(
            backgroundColor: Colors.purple[700],
            title: Text("Pateint Refund List"),
                
            bottom: TabBar(
              tabs: allDoctors.map((e) => Text(e)).toList(),
              // dividerColor: Colors.amber,
              // for (var i = 0; i < allDoctors.length; i++)
              //   {
              //     Text(allDoctors[i]),
              //   },
            ),
          ),
          body: TabBarView(
            children: allDoctors.map((e) => renderPatientList(e)).toList(),
            //   for (var i = 0; i < allDoctors.length; i++) {
            //   renderPatientList(allDoctors[i]),

            // },
//              renderPatientList("Dr Shushma Khare"),
          )),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> renderPatientList(
      String doctorName) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Appointments")
          .where("doctor_name", isEqualTo: doctorName)
          .where("status",isEqualTo: "refund")
          // .orderBy("appointment_no")
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return appointmenttile(
                    AppointmentModel.fromFirestore(snapshot.data!.docs[index]),"Refund",context);
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}



Color getStatusColor(String patientStatus) {
  switch (patientStatus) {
    case "Booked":
      return Colors.green.shade100;

    default:
      return Colors.green.shade500;
  }
}
