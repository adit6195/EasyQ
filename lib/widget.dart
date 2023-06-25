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
Widget appointmenttile(AppointmentModel model) {
  return GestureDetector(
    onTap: () {
      print(model.patientID);
      print(model.name);
      FirebaseFirestore.instance
          .collection("Appointments")
          .doc(model.patientID)
          .update({"name": "true"});

      // ..ext, MaterialPageRoute(builder: (context) => DoctorsInfo()));
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
                                  model.doctorName.toString(),
                                  style: TextStyle(
                                      color: Color(0xffFC9535), fontSize: 17),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: Text(
                                    "+91 " + model.phone.toString(),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            // Spacer(),
                            tag(model.appointmentNo.toString(),
                                Colors.blueAccent,
                                fontsize: 24)
                          ],
                        ),
                        Row(
                          children: [
                            model.isRevisited
                                ? tag("Revisited", Colors.red.shade100)
                                : Container(),
                            tag(model.status.toString() + " Rs",
                                Colors.green.shade100),
                          ],
                        ),
                        text(model.complain)
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
// Its for doctor list view
Widget doctortile(DoctorModel model, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // navigatedirect(DoctorAddPage(model), context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorHomePage(model.doctorName)));
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
