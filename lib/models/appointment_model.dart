import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String name;
  String phone;
  String age;
  bool isMale;
  bool isPriority;
  bool isRevisited;
  // bool priorityApplied;
  String patientID;
  String complain;
  int appointmentNo;
  String doctorName;
  Timestamp registeredTime;
  String status;
  String registeredBy;
  Timestamp scheduledTime;
  Timestamp doctorCheckupTime;

  AppointmentModel({
    required this.name,
    required this.phone,
    required this.age,
    required this.isMale,
    // required this.priorityApplied,
    required this.isRevisited,
    required this.isPriority,
    required this.patientID,
    required this.complain,
    required this.appointmentNo,
    required this.doctorName,
    required this.registeredTime,
    required this.status,
    required this.registeredBy,
    required this.scheduledTime,
    required this.doctorCheckupTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'age': age,
      'isMale': isMale,
      'isPriority': isPriority,
      // 'priority_applied': priorityApplied,
      'isRevisited': isRevisited,
      'complaint': complain,
      "doc_id": patientID,
      'appointment_no': appointmentNo,
      'doctor_name': doctorName,
      "status": status,
      'registered_by': registeredBy,
      'scheduled_time': scheduledTime,
      'registration_time': registeredTime,
      'doctor_checkup_time': doctorCheckupTime,
    };
  }

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return AppointmentModel(
      // id: map['id'];
      name: map['name'],
      phone: map['phone'],
      age: map['age'],
      isMale: map['isMale'],
      isRevisited: map['isRevisited'],
      // priorityApplied: map['priority_applied'],
      patientID: map['doc_id'],
      isPriority: map['isPriority'],
      complain: map['complaint'],
      appointmentNo: map['appointment_no'],
      doctorName: map['doctor_name'],
      registeredTime: map['registration_time'],
      status: map['status'],
      registeredBy: map['registered_by'],
      scheduledTime: map['scheduled_time'],
      doctorCheckupTime: map['doctor_checkup_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromFirestore(json.decode(source));
}
