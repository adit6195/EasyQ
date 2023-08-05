import 'package:easy_q/functions.dart';
import 'package:easy_q/modules/auth/enter_phone.dart';
import 'package:easy_q/modules/doctor/doctors_list.dart';
import 'package:easy_q/role_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerScreen extends StatefulWidget {
  final String doctor;
  const DrawerScreen({required this.doctor});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(20, 50, 10, 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.purple[800]),
              child: Text(
                "Hello \nDr. " + widget.doctor,
                style: GoogleFonts.montserrat(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DoctorsListPage()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Add Doctor",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  Icon(Icons.medical_services_outlined,size: 30,)
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.7,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RolePage()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Add Guard",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width-265,
                  // ),
                  Icon(Icons.add_moderator_outlined,size: 30,)
                ],
              ),
            ),
          ),

          Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Divider(
            color: Colors.black,
            thickness: 0.7,
          ),
          GestureDetector(
            onTap: () {
              
              navigateslide(LoginScreen(), context);
              setPref(false,"");
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Log-Out",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width-240,
                  // ),
                  Icon(Icons.logout_outlined,size: 30,)
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.7,
          ),],)
        ],
      ),
    );
  }
}
