import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/models/doctor_model.dart';
import 'package:easy_q/modules/doctor/doctor_registration.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorTile extends StatelessWidget {
  final DoctorModel model;
  final BuildContext context;
  const DoctorTile({Key? key,required this.model,required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[100]
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {Navigator.push(context,
          MaterialPageRoute(builder: (context) => DoctorRegistrationPage(model)));},
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 19.0,
                              spreadRadius: 0.0
                            )
                          ]
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            model.doctorNumber.toString(),
                            style: TextStyle(color: Colors.black,fontSize: 35),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Dr. "+
                            model.doctorName.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            model.doctorPhone.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
                color: Colors.grey,
                endIndent: 10,indent: 10,thickness: 1,
            ),
            Row(
              children: [
                tag(
                  model.doctorQualification.toString().toUpperCase(),
                  Colors.white
                ),
                SizedBox(
                  width: 5,
                ),
                tag(
                  "Fees: "+model.doctorConsultationFee.toString(),
                  Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}