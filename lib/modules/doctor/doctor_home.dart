import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/modules/doctor/drawer.dart';
import 'package:easy_q/patienttile.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/modules/doctor/doctors_list.dart';
import 'package:easy_q/modules/doctor/patient%20list/all_patient.dart';
import 'package:easy_q/modules/doctor/patient%20list/current_patient.dart';
import 'package:easy_q/role_page.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DoctorHomePage extends StatefulWidget {
  final String doctorName;
  const DoctorHomePage({required this.doctorName});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    final String doctor = widget.doctorName;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerScreen(doctor: doctor),
        // floatingActionButton: SpeedDial(
        //   backgroundColor: Colors.deepPurpleAccent,
        //   spaceBetweenChildren: 5,
        //   spacing: 15,
        //   animatedIcon: AnimatedIcons.menu_close,
        //   children: [
        //     SpeedDialChild(onTap: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) => DoctorsListPage()));
        //     },
        //       label: "Add Doctor",
        //       child: Icon(Icons.add_moderator),
              
        //     ),
        //     SpeedDialChild(
        //       onTap: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) => RolePage()));
        //     },
        //       label: "Add Guard",
        //       child: Icon(Icons.person_add),),
                
        //   ],
        // ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllPatientScreen(doctor:widget.doctorName)));
                }, 
              icon: Icon(Icons.people)
            )
          ],
          backgroundColor: Colors.purple[800],
          title:const Text("Welcome Doctor"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Current Patient"),
              Tab(text: "Emergency"),
              Tab(text: "Priority",)
            ]
          ),
        ),
        body: TabBarView(
          children: 
            [
            SingleChildScrollView(child: CurrentPatientScreen(doctor: widget.doctorName)),
            SingleChildScrollView(child: doctorAppointments("isEmergency",widget.doctorName, "emergency")),
            SingleChildScrollView(child: doctorAppointments("isPriority",widget.doctorName, "priority"))         
            ]
        ),
      ),
    );
  }
}
