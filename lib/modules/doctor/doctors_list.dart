import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_q/components.dart';
import 'package:easy_q/decoration.dart';
import 'package:easy_q/models/doctor_model.dart';
import 'package:easy_q/modules/doctor/doctor_add_page.dart';
import 'package:easy_q/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorsListPage extends StatefulWidget {
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  String? username, phone, userimg, userid;
  @override
  void initState() {
    super.initState();
    // getprefab();
    // username = _age.text;
  }

  // getprefab() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = prefs.getString("name");
  //     userid = prefs.getString("userid");
  //     phone = prefs.getString("Phone");

  //     userimg = prefs.getString("userimg");
  //     print("value is" + userimg.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
        onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DoctorAddPage(null)));
            
        },
      ),
      appBar: AppBar(
        title: Text(
          "Doctors List",
          // style: GoogleFonts.montserrat(font),
        ),
        // backgroundColor: ColorPlatte.primaryColor,
        backgroundColor: Colors.purple[700],
        actions: [],
      ),
      // drawer: CustomDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("doctors")
                    // .where("user_id", isEqualTo: userid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      'No Data...',
                    );
                  } else {
                    // <DocumentSnapshot> items = snapshot.data.documents;

                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // ignore: unused_local_variable

                          return doctortile(
                              DoctorModel.fromFirestore(
                                  snapshot.data!.docs[index]),
                              context);
                        });
                  }
                }),
          ),
        ],
      )),
    );
  }
}
