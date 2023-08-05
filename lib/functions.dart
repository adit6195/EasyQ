import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/guardrole.dart';
import 'package:easy_q/modules/auth/enter_phone.dart';
import 'package:easy_q/modules/doctor/doctor_home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Future> navigateslide(
  Widget pagename,
  BuildContext context,
) async {
  return Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      child: pagename,
    ),
  );
}

Future<Future> navigatedirect(Widget pagename, BuildContext context,
    {isFade = false}) async {
  return Navigator.pushReplacement(
    context,
    PageTransition(
      type: isFade ? PageTransitionType.fade : PageTransitionType.size,
      child: pagename,
    ),
  );
}

Future<void> showSnackMessage(String message, scaffoldKey) {
  return scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(message),
  ));
}

Future<void> checkPhone(String phone, BuildContext context) {
  return FirebaseFirestore.instance
      .collection("Roles")
      .where("phone", isEqualTo: phone)
      .get()
      .then((value) async {
    print(value.docs.length);
    if (value.docs.length > 0) {
      // navigateslide(EnterUsername(), context);
    } else {
      showSnackMessage(
          "this Email is Already registered with another account", context);
    }
  });
}

launchURL(String url) async {
  // const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
getPage(String phone, BuildContext context){
  getUserName(phone).then((value) {
                      if(value != "no_user"){if(value[0]=="*"){Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RoleScreen()));}else{Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorHomePage(doctorName: value)));}}
                          else{ 
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No User Found")));}
                                }
                                );
}

setPref(bool isLogged, String phone)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool("isLogged",isLogged);
    pref.setString("phone", phone);
  }
setRole(String role)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString("role", role);
}
Future <String> getUserName(String number)async{
  String name="no_user";
    await FirebaseFirestore.instance
                    .collection("doctors")
                    .where("doctor_mobile", isEqualTo: number)
                    .get()
                    .then((value) {
                  if (value.docs.isNotEmpty) {
                    name= value.docs[0]["doctor_name"];
                  }
                }
                );
                await FirebaseFirestore.instance
                    .collection("guard")
                    .where("phone", isEqualTo: number)
                    .get()
                    .then((value) {
                  if (value.docs.isNotEmpty) {
                    name= "*"+value.docs[0]["name"];
                  }
                }
                );
return name;
}

// callNumber(String number) async {
//   print("Called");
//   bool? res = await FlutterPhoneDirectCaller.callNumber(number);
// }

setprefab(
  bool isLogged,
  String userid,
) async {
  print(userid);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogged", isLogged);
  prefs.setString("userid", userid.toString());
}
