import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/patienttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UndoStatePage extends StatefulWidget {

  String role;
  UndoStatePage({required this.role});

  @override
  State<UndoStatePage> createState() => _UndoStatePageState();
}

class _UndoStatePageState extends State<UndoStatePage> {
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
            title: Text("Pateint Undo List"),
                
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
      String doctorName, String role) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Appointments")
          .where("doctor_name", isEqualTo: doctorName)
          .where("status",isEqualTo: getUndoFilter(role))
          // .orderBy("appointment_no")
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return AppontmentTile(
                    model: AppointmentModel.fromFirestore(snapshot.data!.docs[index]),role: "undo",context: context);
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
  String getUndoFilter(String role){
    if(role == "Waiting Room"){
    return "waiting";
  }
  else if(role =="Doctor Room"){
    return "doctor room";
  }
  else{
    return "room 3";
  }
}
}