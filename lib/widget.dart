import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/functions.dart';
import 'package:easy_q/decoration.dart';
import 'package:easy_q/patienttile.dart';
import 'package:easy_q/modules/doctor/doctor_add_page.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/models/doctor_model.dart';
import 'package:easy_q/modules/doctor/doctor_home.dart';
import 'package:easy_q/modules/doctor/doctor_registration.dart';
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
      bool ischecked = false;
      List<DropdownMenuItem<String>>? itemlist1=[DropdownMenuItem(child: Text("Done"),value: "completed"),DropdownMenuItem(child: Text("Go To Room 3"), value: "room 3 queue"),DropdownMenuItem(child: Text("Refer"), value: "refered")];
      String currentDropDownMenu = "completed"; 
      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
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
                          Row(
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
                              Spacer(),
                              model.status == "doctor room"
                ?
                    Container(
                      // alignment: Alignment.topRight,
                      color: Colors.amber,
                      height: 20,
                      width: 20,
                      child: CheckboxListTile(
                        // title: Text("Refund"),
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
                              model.age +  " "+model.ageFormat.toString() +"   " +model.gender[0].toString(),
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
                  role != "allpatient"
                  ? Text("Action: ",style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),)
                                            : Container(),
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          )
                          : role == "Room 3"
                        ? Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  print(model.patientID);
                                  FirebaseFirestore.instance
                                      .collection("Appointments")
                                      .doc(model.patientID)
                                      .update({"status": "completed"});
                                  print("check");
                                },
                                child: Text("Done"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                          ElevatedButton(
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
                          ],
                        )
                          : model.status == "doctor room"
                ? 
                        DropdownButton<String>(
                                    items: itemlist1,
                                    value: currentDropDownMenu,
                                    onChanged: (value) {
                                      currentDropDownMenu=value!;
                                      FirebaseFirestore.instance
                                          .collection("Appointments")
                                          .doc(model.patientID)
                                          .update({"status":value});
                                    })
                : role == "Refund" && model.isRefund == true
                                ? ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Appointments")
                                          .doc(model.patientID)
                                          .update({"status": "done", "fees":0,"isRefund" : false});
                                    },
                                    child: Text("Refund"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                  )
                                  : Container(),
                SizedBox(
                  width: 5,
                ),
               role == "doctor" && model.isCalled == false && model.status != "doctor room"
            ? ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Appointments")
                          .doc(model.patientID)
                          .update({"isCalled": true});
                    },
                    child: Text("Call"))
                : Container(),
                ],
              )
            ],
          ),
        ),
      );
  // return Container(
  //   margin: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
  //   decoration: BoxDecoration(
  //       color: model.status == "registered"
  //           ? Colors.amber
  //           : model.status == "waiting"
  //               ? Colors.orange
  //               : model.status == "room 3 queue"
  //                   ? Colors.cyanAccent
  //                   : model.status == "room 3"
  //                       ? Colors.lightGreen
  //                       : model.status == "refered"
  //                       ? Colors.blueGrey
  //                       : model.status == "refunded"
  //                       ? Colors.purple
  //                       : model.status == "doctor room"
  //                       ? Colors.blue
  //                       : Colors.green,
  //       borderRadius: BorderRadius.circular(20)),
  //   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
  //   child: Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Container(
  //             // decoration: BoxDecoration(

  //             // color: model.isPriority ==  true ? Colors.red : Colors.transparent,),
  //             // padding: EdgeInsets.all(5),
  //             // height: 80,
  //             // width: 80,
  //             // decoration: Soft.soft0,
  //             // child: model.gender == "male"
  //             //     ? Image.network(
  //             //         "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_male_user-512.png")
  //             //     : Image.network(
  //             //         "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
  //             child: Container(
  //               // height: MediaQuery.of(context).size.height,
  //               margin: const EdgeInsets.symmetric(horizontal: 10),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: model.isPriority == true
  //                       ? Colors.purple
  //                       : model.isEmergency == true
  //                           ? Colors.red
  //                           : Colors.white,
  //                   // color: Colors.white,
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.1),
  //                         blurRadius: 19.0,
  //                         spreadRadius: 0.0)
  //                   ]),
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 model.appointmentNo.toString(),
  //                 style: TextStyle(
  //                   fontSize: 25,
  //                   color: model.isPriority == true
  //                       ? Colors.white
  //                       : model.isEmergency == true
  //                           ? Colors.white
  //                           : Colors.black,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 5,
  //           ),
  //           // VerticalDivider(),
  //           Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   // mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Container(
  //                               // width:MediaQuery.of(context).size.width*0.6,
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     model.name.toString(),
  //                                     style: GoogleFonts.montserrat(
  //                                         fontSize: 18,
  //                                         fontWeight: FontWeight.w500),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Text(
  //                                     model.phone.toString(),
  //                                     style: GoogleFonts.montserrat(
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w500),
  //                                   ),
  //                                   SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           model.gender,
  //                           style: GoogleFonts.montserrat(
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w500),
  //                         ),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           model.age +  model.ageFormat.toString(),
  //                           style: GoogleFonts.montserrat(
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w500),
  //                         ),
  //                                 ],
  //                               ),
  //                             ),
  //                             // Spacer(),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           model.complain,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: GoogleFonts.montserrat(
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w500),
  //                         ),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Text(
  //                           model.patientID,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: GoogleFonts.montserrat(
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w500),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Column(
  //             children: [
  //               Text(model.doctorName),
  //               SizedBox(
  //                 height: 5,
  //               ),
  //               model.isCalled == true ? 
  //               tag(
  //                 "CALLED",
  //                 Colors.green.shade100,
  //               ) : Container(),
  //               SizedBox(
  //                 height: 5,
  //               ),
  //               tag(
  //                 model.status.toString().toUpperCase(),
  //                 Colors.green.shade100,
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               model.status == "doctor room"
  //               ? Row(
  //                 children: [
  //                   Text("Refund:",style: TextStyle(fontSize: 18),),
  //                   Container(
  //                     color: Colors.amber,
  //                     height: 100,
  //                     width: 100,
  //                     child: CheckboxListTile(
  //                       // title: Text("Refund"),
  //                       activeColor: Colors.green,
  //                       value: model.isRefund, 
  //                       onChanged:  (val) {
  //                         ischecked = val!;
  //                         FirebaseFirestore.instance
  //                               .collection("Appointments")
  //                               .doc(model.patientID)
  //                               .update({"isRefund": ischecked});
  //                       }),
  //                   ),
  //                 ],
  //               )
  //               : Container(),
  //               role == "Doctor Room"
  //                   ? ElevatedButton(
  //                       onPressed: () {
  //                         FirebaseFirestore.instance
  //                             .collection("Appointments")
  //                             .doc(model.patientID)
  //                             .update({"status": "doctor room"});
  //                       },
  //                       child: Text("To \nDoctor"),
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.green),
  //                     )
  //                   : role == "Waiting Room"
  //                       ? ElevatedButton(
  //                           onPressed: () {
  //                             print(model.patientID);
  //                             FirebaseFirestore.instance
  //                                 .collection("Appointments")
  //                                 .doc(model.patientID)
  //                                 .update({"status": "waiting"});
  //                             print("check");
  //                           },
  //                           child: Text("To\nWaiting Hall"),
  //                           style: ElevatedButton.styleFrom(
  //                               backgroundColor: Colors.green),
  //                         )
  //                       : role == "Room 3 Queue"
  //                           ? ElevatedButton(
  //                               onPressed: () {
  //                                 FirebaseFirestore.instance
  //                                     .collection("Appointments")
  //                                     .doc(model.patientID)
  //                                     .update({"status": "room 3"});
  //                               },
  //                               child: Text("Go to\nRoom 3"),
  //                               style: ElevatedButton.styleFrom(
  //                                   backgroundColor: Colors.green),
  //                             )
  //                           : role == "Refund" && model.isRefund == true
  //                               ? ElevatedButton(
  //                                   onPressed: () {
  //                                     FirebaseFirestore.instance
  //                                         .collection("Appointments")
  //                                         .doc(model.patientID)
  //                                         .update({"status": "refunded", "fees":"0","isRefund" : false});
  //                                   },
  //                                   child: Text("Refund"),
  //                                   style: ElevatedButton.styleFrom(
  //                                       backgroundColor: Colors.green),
  //                                 )
  //                                 : Container()
                              
  //             ],
  //           ),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           SizedBox(
  //             width: 20,
  //           ),
  //           role == "doctor" && model.isCalled == false
  //           ? ElevatedButton(
  //                   onPressed: () {
  //                     FirebaseFirestore.instance
  //                         .collection("Appointments")
  //                         .doc(model.patientID)
  //                         .update({"isCalled": true});
  //                   },
  //                   child: Text("Call"))
  //               : Container(),
  //           SizedBox(
  //             width: 00,
  //           ),
  //           model.status == "doctor room"
  //               ? Row(
  //                 children: [
  //                   Text("Actions:",style: TextStyle(fontSize: 19),),
  //                   SizedBox(width: 30,),
  //                   DropdownButton<String>(
  //                               items: itemlist1,
  //                               value: currentDropDownMenu,
  //                               onChanged: (value) {
  //                                 currentDropDownMenu=value!;
  //                                 FirebaseFirestore.instance
  //                                     .collection("Appointments")
  //                                     .doc(model.patientID)
  //                                     .update({"status":value});
  //                               }),
  //                 ],
  //               )
  //               : Container(),
              
  //           role == "Room 3"
  //               ? ElevatedButton(
  //                   onPressed: () {
  //                     FirebaseFirestore.instance
  //                         .collection("Appointments")
  //                         .doc(model.patientID)
  //                         .update({"status": "waiting"});
  //                   },
  //                   child: Text("To\nWaiting Hall"))
  //               : Container(),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           role == "Room 3"
  //               ? ElevatedButton(
  //                   onPressed: () {
  //                     FirebaseFirestore.instance
  //                         .collection("Appointments")
  //                         .doc(model.patientID)
  //                         .update({"status": "completed"});
  //                   },
  //                   child: Text("Done"))
  //               : Container(),
  //         ],
  //       )
  //     ],
  //   ),
  // );
}

// Its for doctor list view
Widget doctortile(DoctorModel model, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // navigatedirect(DoctorAddPage(model), context);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DoctorHomePage(doctorName:model.doctorName)));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DoctorRegistrationPage(model)));
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

  // StreamBuilder<QuerySnapshot<Map<String, dynamic>>> doctorAppointments(String filterName, String doctor_name, String role) {
  //   return StreamBuilder(
  //           stream: FirebaseFirestore.instance
  //               .collection("Appointments")
  //               .where("doctor_name", isEqualTo: doctor_name)
  //               .where(filterName, isEqualTo: true)
  //               // .where("status",isEqualTo: "registered")
  //               // .where("status",isEqualTo: "doctor room")
  //               // .where("status",isEqualTo: "waiting")
  //               .orderBy("appointment_no")
  //               .snapshots(),
  //           builder: (context, AsyncSnapshot snapshot) {
  //             if (snapshot.hasData) {
  //               return ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   itemCount: snapshot.data!.docs.length,
  //                   itemBuilder: (context, index) {
  //                     // return text("text");
  //                     if (AppointmentModel.fromFirestore(
  //                                     snapshot.data!.docs[index])
  //                                 .status ==
  //                             "completed" ||
  //                         AppointmentModel.fromFirestore(
  //                                     snapshot.data!.docs[index])
  //                                 .status ==
  //                             "room 3 queue" ||
  //                         AppointmentModel.fromFirestore(
  //                                     snapshot.data!.docs[index])
  //                                 .status ==
  //                             "room 3"||
  //                         AppointmentModel.fromFirestore(
  //                                     snapshot.data!.docs[index])
  //                                 .status ==
  //                             "refunded"||
  //                         AppointmentModel.fromFirestore(
  //                                     snapshot.data!.docs[index])
  //                                 .status ==
  //                             "refered") {
  //                       return Container();
  //                     }

  //                     return AppontmentTile(model:
  //                         AppointmentModel.fromFirestore(
  //                             snapshot.data!.docs[index]),
  //                         role: role,
  //                         context: context);
  //                   });
  //             } else {
  //               return CircularProgressIndicator();
  //             }
  //           },
  //         );
  // }

