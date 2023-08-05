import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/modules/registration/patient_registration_list_page.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'modules/registration/patient_registration_page.dart';

class AppontmentTile extends StatelessWidget {
  final AppointmentModel model;
  final String role;
  final BuildContext context;

  const AppontmentTile({Key? key, required this.model, required this.role, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool ischecked = false;
      List<DropdownMenuItem<String>>? itemlist1=[DropdownMenuItem(child: Text("Done"),value: "completed"),DropdownMenuItem(child: Text("Go To Room 3"), value: "room 3 queue"),DropdownMenuItem(child: Text("Refer"), value: "refered")];
      List<DropdownMenuItem<String>>? itemlist2=[DropdownMenuItem(child: Text("Done"),value: "completed"),DropdownMenuItem(child: Text("To Waiting Hall"), value: "waiting")];
      String currentDropDownMenu = "completed"; 
      String currentDropDownMenu2 ="completed";
    return Card(
        elevation: 2,
        margin: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
        color: model.status == "registered"
            ? Colors.amber[100]
            : model.status == "waiting"
                ? Colors.orange[100]
                : model.status == "room 3 queue"
                    ? Colors.cyanAccent[100]
                    : model.status == "room 3"
                        ? Colors.lightGreen[100]
                        : model.status == "refered"
                        ? Colors.blueGrey[100]
                        : model.status == "doctor room"
                        ? Colors.blue[100]
                        : Colors.white,),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      role == "Registration" || model.status == "doctor room"
                      ? GestureDetector(
                        onTap: () {Navigator.push(context,
          MaterialPageRoute(builder: (context) => PatientRegistrationPage(model: model)));},
                        child: Container(
                        height: 70,
                        width: 70,
                        // margin: const EdgeInsets.symmetric(horizontal: 10,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: model.isPriority == true
                                ? Colors.purple
                                : model.isEmergency == true
                                    ? Colors.red
                                    : Colors.white,
                            // color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 19.0,
                                  spreadRadius: 0.0)
                            ]),
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            model.appointmentNo.toString(),
                            style: TextStyle(
                              fontSize: 35,
                              color: model.isPriority == true
                                  ? Colors.white
                                  : model.isEmergency == true
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        ),
                      )
                      :
                      Container(
                        height: 70,
                        width: 70,
                        // margin: const EdgeInsets.symmetric(horizontal: 10,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: model.isPriority == true
                                ? Colors.purple
                                : model.isEmergency == true
                                    ? Colors.red
                                    : Colors.white,
                            // color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 19.0,
                                  spreadRadius: 0.0)
                            ]),
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            model.appointmentNo.toString(),
                            style: TextStyle(
                              fontSize: 35,
                              color: model.isPriority == true
                                  ? Colors.white
                                  : model.isEmergency == true
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        ),

                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                            model.name.toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                              ),
                              // Spacer(),
                              model.status == "doctor room" && role != "alldoctorpatient"
                ?
                    Container(
                      height: 19,
                      width: 19,
                      // color: Colors.amber,
                      child: Checkbox(
                        activeColor: Colors.green,
                        value: model.isRefund, 
                        onChanged:  (val) {
                          ischecked = val!;
                          FirebaseFirestore.instance
                                .collection("Appointments")
                                .doc(model.patientID)
                                .update({"isRefund": ischecked});
                        }),
                    )
                : Container(),
                            ],
                          ),
                          Container(
                            child: Text(
                                        model.phone.toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                          ),
                          Container(
                            child: Text(
                              model.age +  " "+model.ageFormat.toString() +"   " +model.gender.toString(),
                              style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              model.complain.toString(),
                              // overflow: TextOverflow.e,
                              style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              model.patientID.toString(),
                              // overflow: TextOverflow.e,
                              style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                endIndent: 10,indent: 10,thickness: 1,
              ),
              Row(
                children: [
                  tag(
                  model.status.toString().toUpperCase(),
                  Colors.green.shade100,
                ),
                SizedBox(
                  width: 5,
                ),
                model.isCalled == true ? 
                tag(
                  "CALLED",
                  Colors.green.shade100,
                ) : Container(),
                SizedBox(
                  width: 5,
                ),
                
                tag(
                  "Fees: " + model.fees.toString(),
                  Colors.green.shade100,
                ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  role == "allpatient" || role == "Registration" || role =="alldoctorpatient"
                  ? Container()
                  :Text("Action: ",style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),),


                // role == "emergency" && model.isCalled == true || role == "priority" && model.isCalled == true 
                //         ? Text("No Action Available")
                
                // : 
                SizedBox(
                  width: 50,
                ),
                role == "undo" && model.status == "waiting"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "registered"});
                              print("check");
                            },
                            child: Text("Undo Call"),
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green),
                          ):
                          role == "undo" && model.status == "doctor room"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "waiting"});
                              print("check");
                            },
                            child: Text("Call Back"),
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green),
                          ):
                          role == "undo" && model.status == "room 3"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "room 3 queue"});
                              print("check");
                            },
                            child: Text("Call Back"),
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green),
                          ):
                role == "Waiting Room"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "waiting"});
                              print("check");
                            },
                            child: Text("To Waiting Hall"),
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green),
                          )
                          : role == "Doctor Room"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "doctor room"});
                              print("check");
                            },
                            child: Text("To Doctor"),
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green),
                          )
                          :role == "Room 3 Queue"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "room 3"});
                              print("check");
                            },
                            child: Text("To Room 3"),
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green),
                          )
                          : role == "Room 3"
                        ? 
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: DropdownButton<String>(
                            focusColor: Colors.purple,
                                      items: itemlist2,
                                      value: currentDropDownMenu2,
                                      onChanged: (value) {
                                        currentDropDownMenu=value!;
                                        FirebaseFirestore.instance
                                            .collection("Appointments")
                                            .doc(model.patientID)
                                            .update({"status":value});
                                      }),
                        )
                          : model.status == "doctor room" && role != "alldoctorpatient"
                ? 
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: DropdownButton<String>(
                                      items: itemlist1,
                                      value: currentDropDownMenu,
                                      onChanged: (value) {
                                        currentDropDownMenu=value!;
                                        FirebaseFirestore.instance
                                            .collection("Appointments")
                                            .doc(model.patientID)
                                            .update({"status":value});
                                      }),
                        )
                : role == "Refund" && model.isRefund == true
                                ? ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Appointments")
                                          .doc(model.patientID)
                                          .update({"status": "completed", "fees":0,"isRefund" : false});
                                    },
                                    child: Text("Refund"),
                                    // style: ElevatedButton.styleFrom(
                                    //     backgroundColor: Colors.green),
                                  )
                                  : Container(),
                SizedBox(
                  width: 5,
                ),
               role == "emergency" && model.isCalled == false && model.status != "doctor room" || role == "priority" && model.isCalled == false && model.status != "doctor room"
            ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"isCalled": true});
                    },
                    child: Text("Call"))
                : role == "emergency" && model.isCalled == true && model.status != "doctor room" || role == "priority" && model.isCalled == true && model.status != "doctor room"
            ? ElevatedButton(
              
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"isCalled": false});
                    },
                    child: Text("Undo Call"),
                    
                    )
                : Container(),
                ],
              )
            ],
          ),
        ),
      );
  }
}
 StreamBuilder<QuerySnapshot<Map<String, dynamic>>> doctorAppointments(String filterName, String doctor_name, String role) {
    return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Appointments")
                .where("doctor_name", isEqualTo: doctor_name)
                .where(filterName, isEqualTo: true)
                // .where("status",isEqualTo: "registered")
                // .where("status",isEqualTo: "doctor room")
                // .where("status",isEqualTo: "waiting")
                .orderBy("appointment_no")
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // return text("text");
                      if (AppointmentModel.fromFirestore(
                                      snapshot.data!.docs[index])
                                  .status ==
                              "completed" ||
                          AppointmentModel.fromFirestore(
                                      snapshot.data!.docs[index])
                                  .status ==
                              "room 3 queue" ||
                          AppointmentModel.fromFirestore(
                                      snapshot.data!.docs[index])
                                  .status ==
                              "room 3"||
                          AppointmentModel.fromFirestore(
                                      snapshot.data!.docs[index])
                                  .status ==
                              "refered") {
                        return Container();
                      }
                      return AppontmentTile(model:
                          AppointmentModel.fromFirestore(
                              snapshot.data!.docs[index]),
                          role: role,
                          context: context);
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          );
  }

  