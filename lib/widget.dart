import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/functions.dart';
import 'package:easy_q/decoration.dart';
import 'package:easy_q/modules/doctor/doctor_add_page.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/models/doctor_model.dart';
import 'package:easy_q/modules/doctor/doctor_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget wew() {
  return Container(
    // doctorsscreenjhP (1:345)
    width: double.infinity,
    height: 812,
    decoration: BoxDecoration(
      color: Color(0xfffcfcfc),
    ),
    child: Stack(
      children: [
        Positioned(
          // bgaCD (1:346)
          left: 0,
          top: 0,
          child: Container(
            width: 544,
            height: 899,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageFiltered(
                  // ellipse142tTo (1:348)
                  imageFilter: ImageFilter.blur(
                    sigmaX: 134.5,
                    sigmaY: 134.5,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 426),
                    width: 216,
                    height: 216,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(108),
                      color: Color(0xb760cdff),
                    ),
                  ),
                ),
                ImageFiltered(
                  // ellipse143AAR (1:347)
                  imageFilter: ImageFilter.blur(
                    sigmaX: 60.5,
                    sigmaY: 60.5,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(287, 0, 0, 0),
                    width: 257,
                    height: 257,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(128.5),
                      color: Color(0x4c0ebe7e),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// I think its for register role view
Widget appointmenttile(
    AppointmentModel model, String role, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
    decoration: BoxDecoration(
        color: model.status == "registered"
            ? Colors.amber
            : model.status == "waiting"
                ? Colors.blue
                : model.status == "room 3 queue"
                    ? Colors.cyanAccent
                    : model.status == "room 3"
                        ? Colors.lightGreen
                        : Colors.green,
        borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // decoration: BoxDecoration(

              // color: model.isPriority ==  true ? Colors.red : Colors.transparent,),
              // padding: EdgeInsets.all(5),
              // height: 80,
              // width: 80,
              // decoration: Soft.soft0,
              // child: model.gender == "male"
              //     ? Image.network(
              //         "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_male_user-512.png")
              //     : Image.network(
              //         "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.appointmentNo.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: model.isPriority == true
                        ? Colors.white
                        : model.isEmergency == true
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            // VerticalDivider(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width:MediaQuery.of(context).size.width*0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Divider(
                                    //   color: Colors.black,
                                    //   thickness: 2,
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Text(
                                      model.name.toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      model.phone.toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.gender,
                            style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.age +  model.ageFormat.toString(),
                            style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                          ),
                                  ],
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.complain,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.patientID,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(model.doctorName),
                model.isCalled == true ? 
                tag(
                  "CALLED",
                  Colors.green.shade100,
                ) : Container(),

                tag(
                  model.status.toString().toUpperCase(),
                  Colors.green.shade100,
                ),
                SizedBox(
                  height: 10,
                ),
                role == "Doctor Room"
                    ? ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Appointments")
                              .doc(model.patientID)
                              .update({"status": "doctor room"});
                        },
                        child: Text("To \nDoctor"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      )
                    : role == "Waiting Room"
                        ? ElevatedButton(
                            onPressed: () {
                              print(model.patientID);
                              FirebaseFirestore.instance
                                  .collection("Appointments")
                                  .doc(model.patientID)
                                  .update({"status": "waiting"});
                              print("check");
                            },
                            child: Text("To\nWaiting Hall"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          )
                        : role == "Room 3 Queue"
                            ? ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Appointments")
                                      .doc(model.patientID)
                                      .update({"status": "room 3"});
                                },
                                child: Text("Go to\nRoom 3"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                              )
                            : role == "Refund"
                                ? ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Appointments")
                                          .doc(model.patientID)
                                          .update({"status": "completed"});
                                    },
                                    child: Text("Refund"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                  )
                            //  : model.doctorName == model.doctorName
                            //     ? ElevatedButton(
                            //         onPressed: () {
                            //           FirebaseFirestore.instance
                            //               .collection("Appointments")
                            //               .doc(model.patientID)
                            //               .update({"status": "called"});
                            //         },
                            //         child: Text("Refund"),
                            //         style: ElevatedButton.styleFrom(
                            //             backgroundColor: Colors.green),
                            //       )
                                  : Container()
                              
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            model.status == "doctor room"
                ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"status": "room 3 queue"});
                    },
                    child: Text("Got to\n room 3"))
                : Container(),
            SizedBox(
              width: 20,
            ),
            role == "doctor" && model.isCalled == false
            ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"isCalled": true});
                    },
                    child: Text("Call"))
                : Container(),
            model.status == "doctor room"
                ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"status": "refund"});
                    },
                    child: Text("Refund"))
                : Container(),
            SizedBox(
              width: 20,
            ),
            model.status == "doctor room"
                ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"status": "completed"});
                    },
                    child: Text("Done"))
                : Container(),
            role == "Room 3"
                ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"status": "waiting"});
                    },
                    child: Text("To\nWaiting Hall"))
                : Container(),
            SizedBox(
              width: 20,
            ),
            role == "Room 3"
                ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"status": "completed"});
                    },
                    child: Text("Done"))
                : Container(),
            
          ],
        )
      ],
    ),
  );
}

// Its for doctor list view
Widget doctortile(DoctorModel model, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // navigatedirect(DoctorAddPage(model), context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorHomePage(doctorName:model.doctorName)));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DoctorAddPage(model)));
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
          color: Color(0xffFFEEE0), borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 80,
            width: 80,
            decoration: Soft.soft0,
            child: model.isMale == true
                ? Image.network(
                    "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_male_user-512.png")
                : Image.network(
                    "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
          ),
          SizedBox(
            width: 17,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.doctorName,
                                  style: TextStyle(
                                      color: Color(0xffFC9535), fontSize: 17),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: Text(
                                    "+91 " + model.doctorPhone,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            // Spacer(),
                            tag(model.doctorRegistrationCount.toString(),
                                Colors.blueAccent,
                                fontsize: 24)
                          ],
                        ),
                        Row(
                          children: [
                            tag(model.doctorQualification, Colors.red.shade100),
                            tag(model.doctorConsultationFee + " Rs",
                                Colors.green.shade100),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget tag(String text, Color bgcolor, {double fontsize = 16}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration:
        BoxDecoration(color: bgcolor, borderRadius: BorderRadius.circular(5)),
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 7),
    child: Text(
      text,
      style: GoogleFonts.actor(fontSize: fontsize),
    ),
  );
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
                              "room 3") {
                        return Container();
                      }

                      return appointmenttile(
                          AppointmentModel.fromFirestore(
                              snapshot.data!.docs[index]),
                          role,
                          context);
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          );
  }

