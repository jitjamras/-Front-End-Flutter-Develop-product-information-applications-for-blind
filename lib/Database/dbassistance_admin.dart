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

import 'Editassistance.dart';

class databaseassistance_admin extends StatefulWidget {
  const databaseassistance_admin({super.key, this.ip});
  final ip;

  @override
  State<databaseassistance_admin> createState() => _databaseassistanceState();
}

String lat = "";
String lng = "";

class _databaseassistanceState extends State<databaseassistance_admin> {
  Future getData() async {
    String ip = widget.ip;
    String url = "http://${widget.ip}/flutterdb/readassistance.php";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ฐานข้อมูลขอความช่วยเหลือ',
          style: GoogleFonts.aBeeZee(fontSize: 24, color: Colors.black),
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "ชื่อ - สกุล : " +
                                    list[index]['first_name'] +
                                    " " +
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
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: GestureDetector(
                                      child: Icon(Icons.edit_document),
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Editassistance(
                                                  list: list,
                                                  index: index,
                                                  ip: widget.ip,
                                                ),
                                              ));
                                          Fluttertoast.showToast(
                                              msg: ' แก้ไขข้อมูล ');
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      child: Icon(Icons.delete),
                                      onTap: () {
                                        setState(() {
                                          String url =
                                              "http://${widget.ip}/flutterdb/deleteassistance.php";
                                          http.post(Uri.parse(url), body: {
                                            'user_id': list[index]['user_id'],
                                          });
                                          Fluttertoast.showToast(
                                              msg: ' ลบข้อมูล ');
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                              )
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
