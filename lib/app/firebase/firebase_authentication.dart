import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  static late FirebaseAuth auth; //FirebaseAuth instance

  static void initFirebaseAuth() {
    auth = FirebaseAuth.instance;
  }

  static String get getUserUid {
    return auth.currentUser!.uid;
  }

  static String get getUserName {
    return auth.currentUser!.displayName.toString();
  }

  static Stream<User?> get getUserStream {
    return auth.authStateChanges().map((User? user) {
      if (user == null) {
        return null;
      } else {
        return user;
      }
    });
  }

  static bool isLoggedIn() {
    final User? user = auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  static Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
//      AppRoutes.pop();
//      appSnackBar("Something Went Wrong");
    }
  }

  static Future verifyPhoneNumber(
      {required String verificationId, required String smsCode}) async {
    print(verificationId + " " + smsCode);
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await auth.signInWithCredential(phoneAuthCredential);
      if (auth.currentUser == null) {
        print("User Failed");
      } else {
        print("User Added");
      }
    } catch (e) {
      print("User Failed 2");

      rethrow;
    }
  }
}
