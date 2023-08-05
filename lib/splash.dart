import 'dart:async';

import 'package:easy_q/functions.dart';
import 'package:easy_q/guardrole.dart';
import 'package:easy_q/modules/auth/enter_phone.dart';
import 'package:easy_q/modules/doctor/doctor_home.dart';
import 'package:easy_q/role_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/registration/patient_registration_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setPref();
    getPref();
    Timer(Duration(seconds: 2),(){if(islogged==false){navigateslide((LoginScreen()), context);}else{getPage(phone!, context);}});
  }
  bool ? islogged=false;
  String ? phone="";
  
  getPref()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      islogged = pref.getBool("isLogged");
      phone=pref.getString("phone");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Splash",style: TextStyle(fontSize: 50),),
            Text(islogged.toString()),
            Text(phone.toString()),
          ],
        ),
        
      ),
    );
  }
  
}