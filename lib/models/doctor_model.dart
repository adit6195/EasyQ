import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String doctorName;
  String doctorPhone;
  String doctorQualification;
  String doctorRegistrationNo;
  String doctorConsultationFee;
  String? doctorImage;
  String doctorID;
  String doctorDocID;
  bool isMale;
  String doctorHospitalID;
  int doctorRegistrationCount;
  Timestamp doctorCheckupTime;

  DoctorModel(
      {required this.doctorName,
      required this.doctorPhone,
      required this.doctorQualification,
      required this.doctorRegistrationNo,
      required this.doctorConsultationFee,
      required this.doctorImage,
      required this.doctorID,
      required this.doctorDocID,
      required this.isMale,
      required this.doctorHospitalID,
      required this.doctorCheckupTime,
      required this.doctorRegistrationCount});

  Map<String, dynamic> toMap() {
    return {
      'doctor_name': doctorName,
      'doctor_mobile': doctorPhone,
      'doctor_qualification': doctorQualification,
      'doctor_registration_no': doctorRegistrationNo,
      'doctor_consultation_fee': doctorConsultationFee,
      'doctor_image': doctorImage,
      'doctor_registration_count': doctorRegistrationCount,
      'doctor_id': doctorID,
      "isMale": isMale,
      'doctor_doc_id': doctorDocID,
      'doctor_checkup_time': doctorCheckupTime,
      'doctor_hospital_id': doctorHospitalID,
    };
  }

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return DoctorModel(
      // id: map['id'];
      doctorName: map['doctor_name'],
      doctorPhone: map['doctor_mobile'],
      doctorQualification: map['doctor_qualification'],
      doctorRegistrationNo: map['doctor_registration_no'],
      doctorConsultationFee: map['doctor_consultation_fee'],
      doctorImage: map['doctor_image'],
      doctorRegistrationCount: map['doctor_registration_count'],
      doctorID: map['doctor_id'],
      doctorDocID: map['doctor_doc_id'],
      isMale: map['isMale'],

      doctorCheckupTime: map['doctor_checkup_time'],
      doctorHospitalID: map['doctor_hospital_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromFirestore(json.decode(source));
}
