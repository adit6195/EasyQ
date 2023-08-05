import 'package:easy_q/functions.dart';
import 'package:easy_q/role_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/registration/patient_registration_list_page.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {

  final allRolesList = ["Registration", "Waiting Room", "Doctor Room","Room 3 Queue","Room 3"];
  String? role = "Registration";
  String? frole = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();

  }

  getRole()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      frole=pref.getString("role")??"";
    }
    );
    if(frole!=""){
      Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PatientRegistrationListPage(role: role!)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text("Select your Role"),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200,),
                    Text("Role",style: TextStyle(fontSize: 25),),
                    SizedBox( height: 40,),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
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
              ),
                      ),
                     value: role,
                                    items: allRolesList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                                  onChanged: (val) {
                                    setState(() {
                    role = val as String;
                                    });
                                  },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ElevatedButton(
                      onPressed: () {
                        setRole(role!);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PatientRegistrationListPage(role: role!)));
                            // print(role);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 11,left: 11, top: 11,bottom: 11),
                        child: Text("Done",style: TextStyle(fontSize: 17),),
                      ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                  ),
                                      ),
                    ),
                  ],
                  
                ),
          ),
        ),
      ),
    );
  }
}