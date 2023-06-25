import 'package:cloud_firestore/cloud_firestore.dart';
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
