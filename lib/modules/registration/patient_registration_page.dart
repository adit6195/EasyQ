import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/modules/doctor/doctors_list.dart';
import 'package:easy_q/modules/doctor/crop_image_page.dart';
import 'package:easy_q/modules/doctor/doctor_add_page.dart';
import 'package:easy_q/models/doctor_model.dart';
import 'package:easy_q/modules/registration/patient_registration_list_page.dart';
import 'package:flutter/material.dart';

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({Key? key}) : super(key: key);

  @override
  _PatientRegistrationPageState createState() =>
      _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  String ageType = "Years";
  String doctor = "Ajay";
  String gender = "Male";
  List<DropdownMenuItem<String>> allDoctors = [
    DropdownMenuItem<String>(
      child: Text("Ajay"),
      value: "Ajay",
    ),
    DropdownMenuItem<String>(
      child: Text("Manas Khare"),
      value: "Manas Khare",
    ),
  ];
  // String doc_id = "paVHt021GSF4Z6B1oBVM";
  // int lastAppintmentNo = 0;
  DoctorModel? currentDoctor;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _complaintController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _feeController = TextEditingController();

  List<DropdownMenuItem<String>>? allDoctorsList = [];
  final allGendersList = ["Male", "Female", "Others"];
  // String? gender = "";
 int currentRegistration = 4;
  String doctorDocID = "";
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        title: const Text("Patient Registration"),
        // toolbarHeight: 60.0,
        actions: [],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
              color: Colors.red,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: (currentDoctor != null &&
                            currentDoctor!.doctorImage != null)
                        ? Image.network(currentDoctor!.doctorImage!,
                            fit: BoxFit.cover)
                        : Container(),
                  ),
                  currentDoctor != null
                      ? Text(currentDoctor!.doctorRegistrationCount.toString(),
                          style: TextStyle(fontSize: 40))
                      : Container(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PatientRegistrationListPage(role:"Registration")));
                      },
                      child: Text("Show List")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DoctorAddPage(null)));
                      },
                      child: Text("Add Doctor")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DoctorsListPage()));
                      },
                      child: Text("Crop Demo")),
                ],
              )),
        ),
        // backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textField(_mobileController, "Please Enter The Mobile Number",
                  "Mobile Number",
                  inputType: TextInputType.number),
              textField(_nameController, "Please Enter Your Name", "Name"),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: textField(
                        _ageController, "Please Enter Your Age", "Age",
                        inputType: TextInputType.number),
                  ),
                  SizedBox(width: 20,),
                  ageTypeWidget(),
                ],
              ),
              Column(
                children: [
                  text("Gender"),
                  DropdownButtonFormField(
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
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Priority :   ")
                  ),
                  priorityTypeWidget()
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Revisited:    ")
                  ),
                  revisitedTypeWidget()
                ],
              ),
               Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Emergency:     ")
                  ),
                  emergencyTypeWidget()
                ],
              ),

              textField(_complaintController, "Please Mention Your Complain",
                  "Complain",
                  // minLines: 4
                  ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Doctor"),
                        DropdownButton<String>(
                            items: allDoctors,
                            value: doctor,
                            onChanged: (value) {
                              FirebaseFirestore.instance
                                  .collection("doctors")
                                  .where("doctor_name", isEqualTo: value)
                                  .get()
                                  .then((value) {
                                if (value.docs.length > 0) {
                                  doctor = value.docs[0]["doctor_name"];
                                  doctorDocID = value.docs[0]["doctor_doc_id"];

                                  _feeController.text =
                                      value.docs[0]["doctor_consultation_fee"];
                                  setState(() {
                                    currentRegistration = value.docs[0]
                                        ["doctor_registration_count"];

                                    doctorDocID =
                                        value.docs[0]["doctor_doc_id"];
                                  });
                                  print(currentRegistration);

                                  print(doctorDocID);
                                }
                              });
                            }),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Fees:"),
                        text(_feeController.text),

                      ],
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    registeration();
                    Navigator.pop(context);
                  },
                  child: Text("Register")),
//              ElevatedButton(onPressed: () {}, child: Text("Add Doctor"))
            ],
          ),
        ),
      ),
    );
  }
  void registeration(){
    String patientID = Random().nextInt(1000000).toString();
                    FirebaseFirestore.instance.collection("Appointments").doc(patientID).set({
                      "phone": _mobileController.text,
                      "name": _nameController.text,
                      "age": _ageController.text,
                      "isCalled": false,
                      "isPriority": isPriority,
                      "isRevisited": isRevisited,
                      "gender": gender,
                      "isEmergency" : isEmergency,
                      "ageFormat": ageFormat,
                      "complaint": _complaintController.text,
                      "doctor_name": doctor,
                      "patient_id":patientID,
                      "doctor_doc_id": doctorDocID,
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
                    print(doctorDocID);
                    FirebaseFirestore.instance
                        .collection("doctors")
                        .doc(doctorDocID)
                        .update({
                      "doctor_registration_count": currentRegistration + 1,
                    });
                    // print(doctor)
                    print("all operation scess");
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
        // height: 50,
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
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
              // color: Colors.b,
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
        // height: 50,
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
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
        // height: 50,
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
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
        // height: 50,
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
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

  
