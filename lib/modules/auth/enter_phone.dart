import 'dart:developer';

import 'package:easy_q/app/firebase/firebase_authentication.dart';
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
            decoration: InputDecoration(
              prefix: Text("+91"),
              labelText: 'Mobile Number',
            ),
          ),
          if (!isPhoneNumber)
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'OTP',
              ),
            ),
          SizedBox(height: 20.0),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PatientRegistrationListPage()));
                  },
                  child: isPhoneNumber ? Text('Send OTP') : Text('Verify OTP'),
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
