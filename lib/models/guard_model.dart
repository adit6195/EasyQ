import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GuardModel {
  String guardName;
  String guardPhone;

  GuardModel(
      {required this.guardName,
      required this.guardPhone,});

  Map<String, dynamic> toMap() {
    return {
      'name': guardName,
      'phone': guardPhone,
    };
  }

  factory GuardModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return GuardModel(
      // id: map['id'];
      guardName: map['name'],
      guardPhone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GuardModel.fromJson(String source) =>
      GuardModel.fromFirestore(json.decode(source));
}
