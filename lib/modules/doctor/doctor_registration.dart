import 'dart:math';

import 'package:easy_q/models/doctor_model.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorRegistrationPage extends StatefulWidget {
  DoctorModel? model;
  DoctorRegistrationPage(this.model);

  @override
  State<DoctorRegistrationPage> createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  String gender = "Male";
  TextEditingController _doctorNameController = TextEditingController();
  TextEditingController _doctorQualificationController =
      TextEditingController();
  TextEditingController _doctorMobileController = TextEditingController();
  TextEditingController _doctorRegistrationNumberController =
      TextEditingController();
  TextEditingController _doctorConsultationFeeController =
      TextEditingController();
    TextEditingController _doctorNumberController =
      TextEditingController();
  // TextEditingController _doctorCheckupTimeInSecondController =
  //     TextEditingController();
  int currentRegistration=4;
      String doctor = "Add Doctor";

        checkDoctor() {
    if (widget.model != null) {
      _doctorNameController.text = widget.model!.doctorName;
      _doctorMobileController.text = widget.model!.doctorPhone;
      _doctorQualificationController.text = widget.model!.doctorQualification;
      _doctorRegistrationNumberController.text =
          widget.model!.doctorRegistrationNo;
      _doctorConsultationFeeController.text =
          widget.model!.doctorConsultationFee;
      // _doctorCheckupTimeInSecondController.text =
      //     widget.model!.doctorCheckupTime.toString();
    } else {
      print("New Doctor This Time");
    }
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDoctor();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Doctor"),
        backgroundColor: Colors.purple[700],
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
            textField(
                _doctorNameController, "Please Enter Doctor Name", "Doctor Name",
                // RegExp(r'^[a-zA-Z]+$'),
                ),
            textField(_doctorMobileController, "Please Enter Phone Number",
                "Phone Number",
                // RegExp(r'^[0-9]{10}$'),
                ),
            textField(_doctorQualificationController,
                "Please Enter Qualification", "Qualification",
                // RegExp(r'^[0-9]{10}$'),
                ),
            textField(_doctorRegistrationNumberController,
                "Please Enter Registration", "Registration Number",
                // RegExp(r'^[0-9]{10}$'),
                ),
            textField(_doctorConsultationFeeController,
                "Please Enter Consultation Fee", "Consultation Fee",
                // RegExp(r'^[0-9]{10}$'),
                inputType: TextInputType.number),
            // textField(_doctorCheckupTimeInSecondController,
            //     "Please Enter Duration", "Duration"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:5,vertical: 5),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10,top:10,bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.purple,width: 2)
                      ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        // flex: 1,
                        child: Text("Gender:",style: GoogleFonts.montserrat(
                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                      ),)
                      ),
                      genderTypeWidget()
                    ],
                  ),
              ),
            ),
      ElevatedButton(
                onPressed: () async {
                  // print('kr rha hai print');
                  // await uploadFile(pickedImage, "Doctor", doctor);

                  if (widget.model == null) {
                    String doctorID = Random().nextInt(1000000).toString();
                    FirebaseFirestore.instance.collection("doctors").doc(doctorID).set({
                      "doctor_mobile": _doctorMobileController.text,
                      "doctor_name": _doctorNameController.text,
                      "doctor_qualification": _doctorQualificationController.text,
                      "doctor_registration_no":
                          _doctorRegistrationNumberController.text,
                      "doctor_registration_count": 0,
                      "doctor_consultation_fee":
                          _doctorConsultationFeeController.text,
                      "doctor_id": doctorID,
                      "doctor_hospital_id": "",
                      "doctor_add_update_timestamp": DateTime.now(),
                      "doctor_add_update_userid": "",
                      "gender": gender,
                      "doctor_number": currentRegistration+1,
                      // "doctor_checkup_time":
                      //     int.parse(_doctorCheckupTimeInSecondController.text),
                    }).then((value) => {
                      print('iske andar ja rha hao'),
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Done at Sr#" + DateTime.now().toString())))
                        });
                  } else {
                    FirebaseFirestore.instance
                        .collection("doctors")
                        .doc(widget.model!.doctorID)
                        .update({
                      "doctor_mobile": _doctorMobileController.text,
                      "doctor_name": _doctorNameController.text,
                      "doctor_qualification": _doctorQualificationController.text,
                      "doctor_registration_no":
                          _doctorRegistrationNumberController.text,
                      "doctor_registration_count": 0,
                      "doctor_consultation_fee":
                          _doctorConsultationFeeController.text,
                      "doctor_hospital_id": "",
                      "doctor_add_update_timestamp": DateTime.now(),
                      "doctor_add_update_userid": "",
                      "gender": gender,
                      // "doctor_checkup_time":
                      //     int.parse(_doctorCheckupTimeInSecondController.text),
                    }).then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Done at Sr#" + DateTime.now().toString())))
                            });
                  }
                  // print('prin2');
                  setState(() {
                    doctor = "Add Doctor";
                    widget.model = null;
                  });
                  _doctorNameController.clear();
                  _doctorMobileController.clear();
                  _doctorQualificationController.clear();
                  _doctorRegistrationNumberController.clear();
                  _doctorConsultationFeeController.clear();
                  // _doctorCheckupTimeInSecondController.clear();
      
                  // FirebaseFirestore.instance
                  //     .collection("doctors")
                  //     .doc(widget.model!.doctorDocID)
                  //     .update({
                  //   "doctor_registration_count": registrationCount,
                  // }),
                  // setState(() {
                  //   widget.model!.doctorRegistrationCount =
                  //       registrationCount;
                  // }),
                  //                            });
                  //                },
                  // print("3 by 5");
                },style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  elevation: 5
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.model == null
                  ? Text("Add Doctor",style: GoogleFonts.montserrat(
                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                    ),)
                  : Text("Edit Doctor",style: GoogleFonts.montserrat(
                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                    ),)
                )),
          ]),
        ),
      ),
    );
  }
    void gendertoggleButton() {
    setState(() {
      if (gender == "Male") {
        gender = "Female";
      } else if(gender =="Female"){
        gender = "Others";
      } else{
        gender ="Male";
      }
    });
  }

  Widget genderTypeWidget() {
    return GestureDetector(
      onTap: gendertoggleButton,
      child: Container(
        // padding: EdgeInsets.all(5),
        width: 100,
        height: 25,
        decoration: BoxDecoration(
          // color: Colors.cyanAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            gender == "Male"
                ? 'Male'
                : gender == "Female"
                    ? "Female"
                    : 'Others',
            style: TextStyle(
              // color: Colors.b,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}