import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/models/appointment_model.dart';
import 'package:easy_q/modules/doctor/doctors_list.dart';
import 'package:easy_q/modules/doctor/crop_image_page.dart';
import 'package:easy_q/modules/doctor/doctor_add_page.dart';
import 'package:easy_q/models/doctor_model.dart';
import 'package:easy_q/modules/registration/patient_registration_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientRegistrationPage extends StatefulWidget {
  AppointmentModel? model;
  PatientRegistrationPage({this.model});

  @override
  _PatientRegistrationPageState createState() =>
      _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  String ageType = "Years";
  String gender = "Male";

  List<String> allDoctors = [];
    // DropdownMenuItem<String>(
    //   child: Text("Ajay"),
    //   value: "Ajay",
    // ),
    // DropdownMenuItem<String>(
    //   child: Text("Manas Khare"),
    //   value: "Manas Khare",
    // ),
  // ];

  String doctor="";

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
              // print("All Doctors" + allDoctors[0]),
            });
  }
  // String doc_id = "paVHt021GSF4Z6B1oBVM";
  // int lastAppintmentNo = 0;
  DoctorModel? currentDoctor;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _complaintController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _feeController = TextEditingController();

  // List<DropdownMenuItem<String>>? allDoctorsList = [];
  final allGendersList = ["Male", "Female", "Others"];
  // String? gender = "";
 int currentRegistration = 4;
 String doctorID = "";
 final _formkey = GlobalKey<FormState>(); 
  // Null Function() model =

  //  getDoctorsList() {
  //   FirebaseFirestore.instance
  //       .collection("doctors")
  //       .orderBy("doctor_name")
  //       .get()
  //       .then((value) => {
  //             for (var i = 0; i < value.docs.length; i++)
  //               {
  //                 setState(() {
  //                   allDoctors.add(doc);
  //                   allDoctorsList.add(Doctor(
  //                       doctorName: currentDoctor?.doctorName,
  //                       doctorMobile: value.docs[i]["doctor_mobile"],
  //                       doctorQualification: value.docs[i]
  //                           ["doctor_qualification"],
  //                       doctorRegistrationNo: value.docs[i]
  //                           ["doctor_registration_no"],
  //                       doctorID: value.docs[i]["doctor_id"],
  //                       doctorImage: value.docs[i]["doctor_image"],
  //                       doctorRegistrationCount: value.docs[i]
  //                           ["doctor_registration_count"],
  //                       doctorDocID: value.docs[i].id,
  //                       doctorHospitalID: value.docs[i]["doctor_hospital_id"],
  //                       doctorCheckupTime: value.docs[i]["doctor_checkup_time"],
  //                       doctorConsultationFee: value.docs[i]
  //                           ["doctor_consultation_fee"]));
  //                 })
  //               },
  //             if (value.docs.length > 0)
  //               {
  //                 setState(() {
  //                   doctor = value.docs[0]["doctor_name"];
  //                   currentDoctor = Doctor(
  //                       doctorName: value.docs[0]["doctor_name"],
  //                       doctorMobile: value.docs[0]["doctor_mobile"],
  //                       doctorQualification: value.docs[0]
  //                           ["doctor_qualification"],
  //                       doctorRegistrationNo: value.docs[0]
  //                           ["doctor_registration_no"],
  //                       doctorID: value.docs[0]["doctor_id"],
  //                       doctorImage: value.docs[0]["doctor_image"],
  //                       doctorRegistrationCount: value.docs[0]
  //                           ["doctor_registration_count"],
  //                       doctorDocID: value.docs[0].id,
  //                       doctorHospitalID: value.docs[0]["doctor_hospital_id"],
  //                       doctorCheckupTime: value.docs[0]["doctor_checkup_time"],
  //                       doctorConsultationFee: value.docs[0]
  //                           ["doctor_consultation_fee"]);
  //                   _feeController.text = currentDoctor!.doctorConsultationFee;
  //                 })
  //               },
  //             print(value.docs.length),
  //             print("All Doctors" + allDoctors.length.toString())
  //           });
  // }
  checkPatient() {
    if (widget.model != null) {
      _nameController.text = widget.model!.name;
      _ageController.text=widget.model!.age;
      _complaintController.text=widget.model!.complain;
      _mobileController.text=widget.model!.phone;
      setState(() {
        doctor=widget.model!.doctorName;
      });
      gender=widget.model!.gender;
      isEmergency=widget.model!.isEmergency;
      isPriority=widget.model!.isPriority;
      _feeController.text=widget.model!.fees.toString();
      ageFormat=widget.model!.ageFormat;
      

      // _doctorCheckupTimeInSecondController.text =
      //     widget.model!.doctorCheckupTime.toString();
    } else {
      print("New Patient This Time");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorsList();
    checkPatient();
    print(doctor);
    print("2");
    // print(widget.model!.doctorName);
  }

  String ageFormat = "Years";
  bool isMale = true;
  bool isPriority = false;
  bool isRevisited = false;
  bool isEmergency = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(123, 31, 162, 1),
        title: widget.model == null ?
        
        Text("Patient Registration") : Text("Edit Patient"),
        // toolbarHeight: 60.0,
        // actions: [],
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(50),
        //   child: Container(
        //       color: Colors.red,
        //       height: 50,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           // Container(
        //           //   height: 40,
        //           //   width: 40,
        //           //   child: (currentDoctor != null &&
        //           //           currentDoctor!.doctorImage != null)
        //           //       ? Image.network(currentDoctor!.doctorImage!,
        //           //           fit: BoxFit.cover)
        //           //       : Container(),
        //           // ),
        //           currentDoctor != null
        //               ? Text(currentDoctor!.doctorRegistrationCount.toString(),
        //                   style: TextStyle(fontSize: 40))
        //               : Container(),
        //           ElevatedButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) =>
        //                         PatientRegistrationListPage(role:"Registration")));
        //               },
        //               child: Text("Show List")),
        //           ElevatedButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) => DoctorAddPage(null)));
        //               },
        //               child: Text("Add Doctor")),
        //           ElevatedButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) => DoctorsListPage()));
        //               },
        //               child: Text("Crop Demo")),
        //         ],
        //       )),
        // ),
        // backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                textField(_nameController, "Please Enter Your Name", "Name",
                // RegExp(r'^[a-zA-Z]+$'),
                ),
                textField(_mobileController, "Please Enter The Mobile Number",
                    "Mobile Number",
                    inputType: TextInputType.number),
                 Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: textField(
                          _ageController, "Please Enter Your Age", "Age",
                          // RegExp(r'^[0-9]{10}$'),
                          inputType: TextInputType.number),
                    ),
                    SizedBox(width: 20,),
                    ageTypeWidget(),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:5),
                  child: DropdownButtonFormField(
                  
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                    color: Colors.black
                  ),
                        alignLabelWithHint: true,
                        labelText: "Gender",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 2,
                  color: Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 2,
                  color: Colors.purple,
                    ),
                  ),),
                   value: gender,
                    items: allGendersList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
                  onChanged: (val) {
                    setState(() {
                  gender = val as String;
                    });
                  },
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                textField(_complaintController, "Please Mention Your Complain",
                    "Complain",
                    // RegExp(r'^[0-9]{10}$'),
                    // minLines: 4
                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 3),
                  child: Container(
                    padding: EdgeInsets.only(left:3,right:30,top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.purple,width: 2)
                              ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text("Priority :",
                                      style: GoogleFonts.montserrat(
                                        // color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),),
                          )
                        ),
                        priorityTypeWidget()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 3),
                  child: Container(
                    padding: EdgeInsets.only(left:3,right:30,top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.purple,width: 2)
                              ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text("Revisited:",style: GoogleFonts.montserrat(
                                        // color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),),
                          )
                        ),
                        revisitedTypeWidget()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal:5,vertical: 3),
                   child: Container(
                    padding: EdgeInsets.only(left:3,right:30,top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.purple,width: 2)
                              ),
                     child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text("Emergency:",style: GoogleFonts.montserrat(
                                        // color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),),
                          )
                        ),
                        emergencyTypeWidget()
                      ],
                                 ),
                   ),
                 ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:11),
                      child: Text("Doctor:",style: GoogleFonts.montserrat(
                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.purple,width: 2)
                      ),
                      child: DropdownButton(
                          items: allDoctors.map((e) {
                            return DropdownMenuItem(child: Text(e),value: e);
                          }).toList(),
                          value: widget.model == null ? doctor : widget.model!.doctorName,
                          onChanged: (value) {
                            FirebaseFirestore.instance
                                .collection("doctors")
                                .where("doctor_name", isEqualTo: value)
                                .get()
                                .then((value) {
                              if (value.docs.length > 0) {
                                doctor = value.docs[0]["doctor_name"];
                                doctorID = value.docs[0]["doctor_id"];
                    
                                _feeController.text =
                                    value.docs[0]["doctor_consultation_fee"];
                                setState(() {
                                  currentRegistration = value.docs[0]
                                      ["doctor_registration_count"];
                    
                                  doctorID =
                                      value.docs[0]["doctor_id"];
                                });
                                print(currentRegistration);
                    
                                print(doctorID);
                              }
                            });
                          }),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top:4,bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.purple,width: 2)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text ("Fees:",style: GoogleFonts.montserrat(
                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                      ),),
                          text(_feeController.text),
                    
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    elevation: 5,
                  ),
                    onPressed: ()  async{
                      if(_formkey.currentState?.validate()==true)
                      {
                        if(_mobileController.text.length==10){
                          if(widget.model==null){String patientID = Random().nextInt(1000000).toString();
                      FirebaseFirestore.instance.collection("Appointments").doc(patientID).set({
                        "phone": _mobileController.text,
                        "name": _nameController.text,
                        "age": _ageController.text,
                        "fees":int.parse(_feeController.text),
                        "isCalled": false,
                        "isRefund": false,
                        "isPriority": isPriority,
                        "isRevisited": isRevisited,
                        "gender": gender,
                        "isEmergency" : isEmergency,
                        "ageFormat": ageFormat,
                        "complaint": _complaintController.text,
                        "doctor_name": doctor,
                        "patient_id":patientID,
                        "doctor_id": doctorID,
                        "registration_time": DateTime.now(),
                        "status": "registered",
                        "scheduled_time":
                            DateTime.now().add(Duration(minutes: 30)),
                        "appointment_no": currentRegistration + 1,
                        "registered_by": "bunty",
                        "doctor_checkup_time": Timestamp.now()
          
                      }).then((value) => {
                            // _nameController.clear(),
                            // _ageController.clear(),
                            // _addressController.clear(),
                            // _complaintController.clear(),
                            // _mobileController.clear(),
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Done at Serial no #" +
                                    (currentRegistration + 1).toString())))
                          });
                      print(doctorID);
                      FirebaseFirestore.instance
                          .collection("doctors")
                          .doc(doctorID)
                          .update({
                        "doctor_registration_count": currentRegistration + 1,
                      });
                      // print(doctor)
                      print("all operation scess");
                      } else {
                        FirebaseFirestore.instance.collection("Appointments").doc(widget.model!.patientID).update({
                        "phone": _mobileController.text,
                        "name": _nameController.text,
                        "age": _ageController.text,
                        "fees":int.parse(_feeController.text),
                        "isPriority": isPriority,
                        "isRevisited": isRevisited,
                        "gender": gender,
                        "isEmergency" : isEmergency,
                        "ageFormat": ageFormat,
                        "complaint": _complaintController.text,
                        "doctor_name": doctor,
                        "doctor_id": doctorID,
          
                      }).then((value) => {
                            // _nameController.clear(),
                            // _ageController.clear(),
                            // _addressController.clear(),
                            // _complaintController.clear(),
                            // _mobileController.clear(),
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Updated at Serial no #" +
                                    (currentRegistration ).toString())))
                          });
                      print(doctorID);
                      // FirebaseFirestore.instance
                      //     .collection("doctors")
                      //     .doc(doctorID)
                      //     .update({
                      //   "doctor_registration_count": currentRegistration + 1,
                      // });
                      // print(doctor)
                      print("all operation scess");
                      }
                      Navigator.pop(context);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Enter Valid Mobile Number".toString())));
                    }
                    }},
                    child: 
                    widget.model == null ?
                    Text("Register",style: GoogleFonts.montserrat(
                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                      ),): Text("Edit",style: GoogleFonts.montserrat(
                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                      ),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void toggleButton() {
    setState(() {
      if (ageFormat == "Years") {
        ageFormat = "Months";
      } else if(ageFormat =="Months"){
        ageFormat = "Days";
      } else{
        ageFormat ="Years";
      }
    });
  }

  Widget ageTypeWidget() {
    return GestureDetector(
      onTap: toggleButton,
      child: Container(
        // padding: EdgeInsets.all(5),
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          // color: Colors.cyanAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            ageFormat == "Years"
                ? 'Years'
                : ageFormat == "Months"
                    ? "Months"
                    : 'Days',
            style: TextStyle(
              // color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }


  void emergencytoggleButton() {
    setState(() {
      isEmergency = !isEmergency;
    });
  }
  Widget emergencyTypeWidget() {
    return GestureDetector(
      onTap: emergencytoggleButton,
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
            isEmergency == true ? 'Yes' : "No",
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


    void prioritytoggleButton() {
    setState(() {
      isPriority = !isPriority;
    });
  }


  Widget priorityTypeWidget() {
    return GestureDetector(
      onTap: prioritytoggleButton,
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
            isPriority == true ? 'Yes' : "No",
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

    void revisitedtoggleButton() {
    setState(() {
      isRevisited = !isRevisited;
    });
  }


  Widget revisitedTypeWidget() {
    return GestureDetector(
      onTap: revisitedtoggleButton,
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
            isRevisited== true ? 'Yes' : "No",
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

  
