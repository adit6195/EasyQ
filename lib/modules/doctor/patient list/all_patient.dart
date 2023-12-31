import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/patienttile.dart';
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
  DateTime thisdate = DateTime.now();
  num x = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sumall(thisdate, widget.doctor).
    then((value) {
      setState(() {
        x=value;
      });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // selectDate();
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
                //       FirebaseFirestore.instance.collection("Appointments").doc(value.docs[i]["patient_id"]).update({"fees":200});
                //       print("adding" + "200");
                //     }
                //   }
                // }
                // );
              },
              icon: const Icon(Icons.calendar_month))
        ],
        backgroundColor: Colors.purple[800],
        title: const Text("All Patient"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Date: "+thisdate.day.toString()+"/"+thisdate.month.toString()+"/"+thisdate.year.toString(),
              style: TextStyle(fontSize: 30),
            ),
            // Text("text" + widget.doctor, style: TextStyle(fontSize: 50)),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Appointments")
                  .where("doctor_name", isEqualTo: widget.doctor)
                  // .where("registration_time", isEqualTo: thisdate.day+thisdate.month+thisdate.year)
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
                              role: "allpatient",
                              context: context);
                        } else {
                          return Container();
                        }
                        
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Text("Today's Total" + x.toString())
          ],
        ),
      ),
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
      sumall(thisdate,widget.doctor).then((value) {
                  setState(() {
                    x=value;
                  // print(x);
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

