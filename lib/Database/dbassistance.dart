import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/Database/Editmember.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class databaseassistance extends StatefulWidget {
  const databaseassistance({super.key, this.ip});
  final ip;

  @override
  State<databaseassistance> createState() => _databaseassistanceState();
}

String lat = "";
String lng = "";

class _databaseassistanceState extends State<databaseassistance> {
  Future getData() async {
    String url = "http://${widget.ip}/flutterdb/readassistance.php";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ขอความช่วยเหลือจากผู้พิการทางสายตา',
          style: GoogleFonts.aBeeZee(fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Color(0xffFFCF9F),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xffEFB171),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: ((context, index) {
                    List list = snapshot.data;
                    return SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              if (list[index]['status_assistance'] ==
                                  "ต้องการความช่วยเหลือ") ...[
                                Text(
                                  "ชื่อ - สกุล : " +
                                      list[index]['first_name'] +
                                      "  " +
                                      list[index]['last_name'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "เบอร์โทร : " + list[index]['phone_number'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ที่อยู่ : " + list[index]['user_address'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ละติจูด  : " + list[index]['latitude'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ลองจิจูด : " + list[index]['longitude'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ต้องการผู้ช่วยเหลือ เพศ : " +
                                      list[index]['request_gender'],
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.map,
                                    size: 32,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      lat = list[index]['latitude'];
                                      lng = list[index]['longitude'];
                                      gotoMap();
                                    });
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                )
                              ],
                            ],
                          )),
                    );
                  }))
              : CircularProgressIndicator();
        },
      ),
    );
  }
}

gotoMap() async {
  try {
    var url =
        //"https://www.google.com/maps/dir/?api=1&destination=11.6021526,104.9112173";
        "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng";
    final Uri _url = Uri.parse(url);
    launchUrl(_url);
  } catch (_) {
    print("Error launch Map");
  }
}
