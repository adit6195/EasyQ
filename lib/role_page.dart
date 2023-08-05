import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/app/firebase/firebase_authentication.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/models/guard_model.dart';
import 'package:easy_q/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RolePage extends StatefulWidget {
  GuardModel? model;
  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  // String? _selectedItem;

  // List<String> _items = [
  //   "Doctor",
  //   "Gate Keeper"
  // ];
  String verificationCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Guard"),
        backgroundColor: Color.fromRGBO(123, 31, 162, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textField(_nameController,"Please Enter Your Name", "Name"),
              textField(_phoneController, "Please Enter your Mobile Number","Mobile Number"),
              SizedBox(height: 20.0),
              // Container(
              //   width: 400,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.grey.shade500,
              //       width: 1.5,
              //     ),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: DropdownButton<String>(
              //     value: _selectedItem,
              //     icon: Icon(Icons.arrow_drop_down),
              //     iconSize: 24,
              //     elevation: 16,
              //     style: TextStyle(
              //       color: Colors.black87,
              //       fontSize: 16,
              //     ),
              //     underline: Container(
              //       height: 0,
              //     ),
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         _selectedItem = newValue;
              //       });
              //     },
              //     items: _items.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
              ElevatedButton(
                  onPressed: () {
                    print("Tapped");
      
                    FirebaseFirestore.instance.collection("guard").add({
                      "name": _nameController.text,
                      "phone": _phoneController.text,
                    });
                    print("ho gya");
                  },
                  child: Text('Add Role'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent
                  ),
                  ),
              wew()
            ],
          ),
        ),
      ),
    );
  }

  wew() {
    return Container(
      // doctorsscreenjhP (1:345)
      width: 400,
      height: 312,
      decoration: BoxDecoration(
        color: Color(0xfffcfcfc),
      ),
      child: Stack(
        children: [],
      ),
    );
  }
}
