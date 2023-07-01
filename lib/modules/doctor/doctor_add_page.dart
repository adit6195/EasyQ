import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/doctor_model.dart';

class DoctorAddPage extends StatefulWidget {
  DoctorModel? model;
  DoctorAddPage(this.model);

  @override
  State<DoctorAddPage> createState() => _DoctorAddPageState();
}

class _DoctorAddPageState extends State<DoctorAddPage> {
  TextEditingController _doctorNameController = TextEditingController();
  TextEditingController _doctorQualificationController =
      TextEditingController();
  TextEditingController _doctorMobileController = TextEditingController();
  TextEditingController _doctorRegistrationNumberController =
      TextEditingController();
  TextEditingController _doctorConsultationFeeController =
      TextEditingController();
  TextEditingController _doctorCheckupTimeInSecondController =
      TextEditingController();

  String doctor = "Add Doctor";
  File? pickedImage;
  String? imageUrl = "";

  // List<String> allDoctors = ["Add Doctor"];

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(image!.path);
    });
    _cropImage();
  }

  Future _cropImage() async {
    pickedImage!.length().then(((value) {
      print("Before" + value.toString());
    }));

    int currentSize = await pickedImage!.length();
    int compressionRatio = ((250000 / currentSize) * 100).toInt();
    print("Ratio" + compressionRatio.toString());
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      cropStyle: CropStyle.rectangle,

      compressQuality: compressionRatio,
      // uiSettings: [
      //   AndroidUiSettings(
      //       toolbarTitle: 'Cropper',
      //       toolbarColor: Colors.deepOrange,
      //       toolbarWidgetColor: Colors.white,
      //       initAspectRatio: CropAspectRatioPreset.original,
      //       lockAspectRatio: false),
      //   IOSUiSettings(
      //     title: 'Cropper',
      //   )
      // ],
    );
    if (croppedFile != null) {
      setState(() {
        pickedImage = File(croppedFile.path);
      });
      pickedImage!.length().then(((value) {
        print("After" + value.toString());
      }));
    }
  }

  Future<UploadTask?> uploadFile(
      File? file, String folderName, String fileName) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return null;
    }

    UploadTask uploadTask;
    // String folderName = 'flutter-tests';
    // String fileName = 'some-image.jpg';

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child('/' + fileName + '.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    uploadTask = ref.putFile(file, metadata);

    imageUrl = await ref.getDownloadURL();

    // print(imageUrl);
    return Future.value(uploadTask);
  }

  checkDoctor() {
    if (widget.model != null) {
      _doctorNameController.text = widget.model!.doctorName;
      _doctorNameController.text = widget.model!.doctorName;
      _doctorMobileController.text = widget.model!.doctorPhone;
      _doctorQualificationController.text = widget.model!.doctorQualification;
      _doctorRegistrationNumberController.text =
          widget.model!.doctorRegistrationNo;
      _doctorConsultationFeeController.text =
          widget.model!.doctorConsultationFee;
      _doctorCheckupTimeInSecondController.text =
          widget.model!.doctorCheckupTime.toString();
      imageUrl = widget.model!.doctorImage;
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
          child: Column(children: [
            textField(
                _doctorNameController, "Please Enter Doctor Name", "Doctor Name",),
            textField(_doctorMobileController, "Please Enter Phone Number",
                "Phone Number"),
            textField(_doctorQualificationController,
                "Please Enter Qualification", "Qualification"),
            textField(_doctorRegistrationNumberController,
                "Please Enter Registration", "Registration"),
            textField(_doctorConsultationFeeController,
                "Please Enter Consultation Fee", "Consultation Fee"),
            textField(_doctorCheckupTimeInSecondController,
                "Please Enter Duration", "Duration"),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Container(
                height: 80,
                width: 80,
                child: pickedImage != null
                    ? Image.file(pickedImage!, fit: BoxFit.cover)
                    : (widget.model != null && widget.model!.doctorImage != null)
                        ? Image.network(widget.model!.doctorImage!,
                            fit: BoxFit.cover)
                        : Container(
                            decoration: BoxDecoration(border: Border.all()),
                          ),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       uploadFile(pickedImage, "Doctor", doctor);
            //     },
            //     child: Text("Push Image")),
            ElevatedButton(
                onPressed: () async {
                  // await uploadFile(pickedImage, "Doctor", doctor);
                  if (widget.model != null) {
                    FirebaseFirestore.instance.collection("doctors").add({
                      "doctor_mobile": _doctorMobileController.text,
                      "doctor_name": _doctorNameController.text,
                      "doctor_qualification": _doctorQualificationController.text,
                      "doctor_registration_no":
                          _doctorRegistrationNumberController.text,
                      "doctor_registration_count": 0,
                      "doctor_consultation_fee":
                          _doctorConsultationFeeController.text,
                      "doctor_id": "",
                      "doctor_hospital_id": "",
                      "doctor_image": imageUrl,
                      "doctor_add_update_timestamp": DateTime.now(),
                      "doctor_add_update_userid": "",
                      "doctor_checkup_time":
                          int.parse(_doctorCheckupTimeInSecondController.text),
                    }).then((value) => {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Done at Sr#" + DateTime.now().toString())))
                        });
                  } else {
                    FirebaseFirestore.instance
                        .collection("doctors")
                        .doc(widget.model!.doctorDocID)
                        .update({
                      "doctor_mobile": _doctorMobileController.text,
                      "doctor_name": _doctorNameController.text,
                      "doctor_qualification": _doctorQualificationController.text,
                      "doctor_registration_no":
                          _doctorRegistrationNumberController.text,
                      "doctor_registration_count": 0,
                      "doctor_consultation_fee":
                          _doctorConsultationFeeController.text,
                      "doctor_id": "",
                      "doctor_hospital_id": "",
                      "doctor_image": imageUrl,
                      "doctor_add_update_timestamp": DateTime.now(),
                      "doctor_add_update_userid": "",
                      "doctor_checkup_time":
                          int.parse(_doctorCheckupTimeInSecondController.text),
                    }).then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Done at Sr#" + DateTime.now().toString())))
                            });
                  }
                  setState(() {
                    doctor = "Add Doctor";
                    imageUrl = null;
                    widget.model = null;
                    pickedImage = null;
                  });
                  _doctorNameController.clear();
                  _doctorMobileController.clear();
                  _doctorQualificationController.clear();
                  _doctorRegistrationNumberController.clear();
                  _doctorConsultationFeeController.clear();
                  _doctorCheckupTimeInSecondController.clear();
      
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
                },style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add Doctor",style: TextStyle(fontSize: 18),),
                )),
          ]),
        ),
      ),
    );
  }
}
