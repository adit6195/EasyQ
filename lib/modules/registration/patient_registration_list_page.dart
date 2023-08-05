import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/functions.dart';
import 'package:easy_q/modules/doctor/patient%20list/all_doctor_patient.dart';
import 'package:easy_q/modules/doctor/patient%20list/all_patient.dart';
import 'package:easy_q/modules/doctor/patient%20list/undo_page.dart';
import 'package:easy_q/patienttile.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/modules/doctor/patient%20list/refund_page.dart';
import 'package:easy_q/modules/registration/patient_registration_page.dart';
import 'package:easy_q/role_page.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientRegistrationListPage extends StatefulWidget {
  String role;
  PatientRegistrationListPage({required this.role});

  @override
  State<PatientRegistrationListPage> createState() =>
      _PatientRegistrationListPageState();
}

class _PatientRegistrationListPageState
    extends State<PatientRegistrationListPage> {
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
          floatingActionButton:widget.role=="Registration" ? FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.person_add_alt_1),
              onPressed: () {
                navigateslide(PatientRegistrationPage(), context);
              }):null,
          appBar: AppBar(
            actions: [
              widget.role=="Registration"? IconButton(onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RefundScreen()));
              },icon: Icon(Icons.money))
              : widget.role !="Registration" && widget.role != "Room 3"?
              IconButton(onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UndoStatePage(role: widget.role)));
              },icon: Icon(Icons.account_tree))
              : Container(),
              widget.role=="Registration"? IconButton(onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllDoctorPatient()));
              },icon: Icon(Icons.groups_3_outlined))
              : Container(),
              // widget.role=="Registration"? IconButton(onPressed:() {
              //   Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => ()));
              //   },icon: Icon(Icons.money))
              //   : Container()
            ],
            backgroundColor: Color.fromRGBO(123, 31, 162, 1),
            title: widget.role=="Doctor Room"?Text("Doctor Waiting list") : widget.role=="Room 3 Queue"? Text("Room 3 Queue") : widget.role=="Room 3"? Text("Room 3"): widget.role=="Waiting Room"? Text("Waiting Room"): Text("Patient List"),
                
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
            children: allDoctors.map((e) => renderPatientList(e,widget.role)).toList(),
            //   for (var i = 0; i < allDoctors.length; i++) {
            //   renderPatientList(allDoctors[i]),

            // },
//              renderPatientList("Dr Shushma Khare"),
          )),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> renderPatientList(
      String doctorName,String role,) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Appointments")
          .where("doctor_name", isEqualTo: doctorName)
          .where("status",isEqualTo: getFilter(role))
          .orderBy("isCalled",descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return AppontmentTile(
                    model: AppointmentModel.fromFirestore(snapshot.data!.docs[index]),role: role,context: context);
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

String getFilter(String role){
  if (role == "Registration"){
    return "registered";
  }
  else if(role == "Waiting Room"){
    return "registered";
  }
  else if(role =="Doctor Room"){
    return "waiting";
  }
  else if(role =="Room 3 Queue"){
    return "room 3 queue";
  }
  else{
    return "room 3";
  }
}

