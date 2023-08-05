import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/patienttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AllDoctorPatient extends StatefulWidget {
  const AllDoctorPatient({Key? key}) : super(key: key);

  @override
  State<AllDoctorPatient> createState() => _AllDoctorPatientState();
}

class _AllDoctorPatientState extends State<AllDoctorPatient> {
  DateTime thisdate = DateTime.now();
  num x = 0;

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
    sumall(thisdate, doctor).
    then((value) {
      setState(() {
        x=value;
      });
      });
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
            actions: [
              IconButton(
              onPressed: () {
                selectDate();
                print("ho rha hai?");
                
                // FirebaseFirestore.instance
                //     .collection("Appointments")
                //     .get()
                //     .then((value) {
                //   if (value.docs.isNotEmpty) {
                //     for (var i = 0; i < value.docs.length; i++){
                //       FirebaseFirestore.instance.collection("Appointments").doc(value.docs[i]["patient_id"]).update({"isRefund":true});
                //       print("adding" + "200");
                //     }
                //   }
                // }
                // );
              },
              icon: const Icon(Icons.calendar_month))
            ],
            backgroundColor: Colors.purple[700],
            title: Text("All Patient"),
                
            bottom: TabBar(
              tabs: allDoctors.map((e) => Text(e)).toList(),
            ),
          ),
          bottomNavigationBar: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
              
              Text("Date: "+thisdate.day.toString()+"/"+thisdate.month.toString()+"/"+thisdate.year.toString()),
              Text("Fees:"+x.toString())
            ],)
          ),
          body: TabBarView(
            children: allDoctors.map((e) => renderPatientList(e)).toList(),
          )
        ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> renderPatientList(
      String doctorName) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Appointments")
          .where("doctor_name", isEqualTo: doctorName)
          // .orderBy("appointment_no")
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DateTime registeredtime =
                            AppointmentModel.fromFirestore(
                                    snapshot.data!.docs[index])
                                .registeredTime
                                .toDate();
                        // return text("text");
                        if (registeredtime.day == thisdate.day &&
                            registeredtime.month == thisdate.month &&
                            registeredtime.year == thisdate.year) {
                          return AppontmentTile(
                              model: AppointmentModel.fromFirestore(
                                  snapshot.data!.docs[index],),
                              role: "alldoctorpatient",
                              context: context);
                        } else {
                          return Container();
                        }
                        
                      });
        } else {
          return CircularProgressIndicator();
        }
      },
    );

  }
  void selectDate() {
    showDatePicker(
            context: context,
            initialDate: Timestamp.now().toDate(),
            firstDate: DateTime(200),
            lastDate: DateTime(5000))
        .then((value) {
      setState(() {
        thisdate = value!;
      });
      sumall(thisdate,doctor).then((value) {
                  setState(() {
                    x=value;
                  });
                  print(x.toString());
                });
    }
    );
  }
}
Future <num> sumall(DateTime thisdate, String doctorname)async{
  num sum = 0;
  await FirebaseFirestore.instance
                    .collection("Appointments")
                    .where("doctor_name", isEqualTo: doctorname)
                    .get()
                    .then((value) {
                  if (value.docs.isNotEmpty) {
                    for (var i = 0; i < value.docs.length; i++){
                      DateTime registeredtime= value.docs[i]["registration_time"].toDate();
                      if (registeredtime.day == thisdate.day &&
                            registeredtime.month == thisdate.month &&
                            registeredtime.year == thisdate.year){
                      sum += value.docs[i]["fees"];}
                    }
                  }
                });
   return sum;
}

