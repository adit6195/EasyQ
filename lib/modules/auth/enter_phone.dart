import 'dart:developer';

import 'package:easy_q/app/firebase/firebase_authentication.dart';
import 'package:easy_q/guardrole.dart';
import 'package:easy_q/modules/doctor/doctor_home.dart';
import 'package:easy_q/modules/doctor/doctors_list.dart';
import 'package:easy_q/role_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../registration/patient_registration_list_page.dart';
import '../registration/patient_registration_page.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        title: Text('Login Screen'),
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPhoneNumber = true;
  bool isSendingOTP = false;
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  String verificationCode = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            readOnly: !isPhoneNumber,
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              // suffix: Icon(
              //   Icons.phone,
              //   color: Colors.black,
              // ),
              prefix: Text("+91"),
              labelText: 'Mobile Number',
              labelStyle: TextStyle(
                color: Colors.black
              ),
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
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          if (!isPhoneNumber)
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'OTP',
                labelStyle: TextStyle(
                  color: Colors.black
                ),
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
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
              ),
            ),
          SizedBox(height: 50.0),
          isSendingOTP
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    // if (isPhoneNumber) {
                    //   setState(() {
                    //     isSendingOTP = true;
                    //   });
                    //   // Perform login logic here
                    //   String mobileNumber = _mobileController.text;
                    //   print(
                    //       'Login button pressed. Mobile number: $mobileNumber');
                    //   getOTPonPhoneNumber(number: "+91" + mobileNumber)
                    //       .then((value) => {
                    //             print("verifivatopm vpfr0" + value.toString()),
                    //             setState(() {
                    //               isPhoneNumber = false;
                    //             }),
                    //           });
                    // } else {
                    //   FirebaseAuthentication.verifyPhoneNumber(
                    //       verificationId: verificationCode,
                    //       smsCode: _otpController.text);
                    // }
                    if (_mobileController.text == "9977443900") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorHomePage(doctorName: "Ajay")));
                    }
                    else if (_mobileController.text == "9425143900") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorHomePage(doctorName: "Manas Khare")));
                    }
                    
                     else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RoleScreen()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 11,left: 11, top: 15,bottom: 15),
                    child: isPhoneNumber ? Text('Send OTP',style: TextStyle(fontSize: 17),) : Text('Verify OTP',style: TextStyle(fontSize: 17),),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                  ),
                ),
        ],
      ),
    );
  }

  Future getOTPonPhoneNumber({
    required String number,
  }) async {
    String? userVerificationId;
    log('case 1');
    try {
      await FirebaseAuthentication.auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        timeout: const Duration(seconds: 20),
        verificationFailed: (FirebaseAuthException e) {
//          AppRoutes.pop();
//          appSnackBar("Something Went Wrong\nPlease try again after some time");

          log('case 2=============================');
        },
        codeSent: (String verificationId, int? resendToken) {
          log('case 2');

          log('vv$verificationId');

          userVerificationId = verificationId;

          verificationCode = verificationId;
          setState(() {
            isSendingOTP = false;
          });
          //        AppRoutes.pop();
          //        AppRoutes.go(AppRouteName.otpPage,
          //           arguments: OTPScreenArguments(verificationCode: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      //AppRoutes.pop();
      log('case 3');
      return userVerificationId ?? '';
    } catch (e) {
      log("error=================");
      rethrow;
    }
  }
}
