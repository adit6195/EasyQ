import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String doctorName;
  String doctorPhone;
  String doctorQualification;
  String doctorRegistrationNo;
  String doctorConsultationFee;
  // String? doctorImage;
  String doctorID;
  int doctorNumber;
  String gender;
  String doctorHospitalID;
  int doctorRegistrationCount;
  // Timestamp doctorCheckupTime;

  DoctorModel(
      {required this.doctorName,
      required this.doctorPhone,
      required this.doctorQualification,
      required this.doctorRegistrationNo,
      required this.doctorConsultationFee,
      // required this.doctorImage,
      required this.doctorID,
      required this.doctorNumber,
      required this.gender,
      required this.doctorHospitalID,
      // required this.doctorCheckupTime,
      required this.doctorRegistrationCount});

  Map<String, dynamic> toMap() {
    return {
      'doctor_name': doctorName,
      'doctor_mobile': doctorPhone,
      'doctor_qualification': doctorQualification,
      'doctor_registration_no': doctorRegistrationNo,
      'doctor_consultation_fee': doctorConsultationFee,
      // 'doctor_image': doctorImage,
      'doctor_registration_count': doctorRegistrationCount,
      'doctor_id': doctorID,
      "isMale": gender,
      'doctor_number': doctorNumber,
      // 'doctor_checkup_time': doctorCheckupTime,
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
      // doctorImage: map['doctor_image'],
      doctorRegistrationCount: map['doctor_registration_count'],
      doctorID: map['doctor_id'],
      doctorNumber: map['doctor_number'],
      gender: map['gender'],

      // doctorCheckupTime: map['doctor_checkup_time'],
      doctorHospitalID: map['doctor_hospital_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromFirestore(json.decode(source));
}
