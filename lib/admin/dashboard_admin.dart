import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/Database/dbmember.dart';
import 'package:flutter_database/Database/dbproduct.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';
import 'package:flutter_database/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Database/dbassistance_admin.dart';

class Dashboard_admin extends StatefulWidget {
  const Dashboard_admin({
    super.key,
    this.username,
    this.ip,
  });
  final username;
  final ip;
  @override
  State<Dashboard_admin> createState() => _Dashboard_adminState();
}

class _Dashboard_adminState extends State<Dashboard_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
                title: Text(
                  "Username is ",
                  style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.username.text,
                    style: GoogleFonts.aBeeZee(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                trailing: Image.asset(
                  "assets/images/profile.png",
                  width: 64,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      //Box 1
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffA96725)),
                              onPressed: () {
                                {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return databaseproduct(
                                      ip: widget.ip,
                                    );
                                  }));
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/product.png",
                                        width: 64,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "ข้อมูลผลิตภัณฑ์ในฐานข้อมูล",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                      //Box 2
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffA96725)),
                            onPressed: () {
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return databasemember(
                                    ip: widget.ip,
                                  );
                                }));
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/profile.png",
                                      width: 64,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "ข้อมูลของสมาชิกในฐานข้อมูล",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      //Box 3
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffA96725)),
                            onPressed: () {
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return databaseassistance_admin(
                                    ip: widget.ip,
                                  );
                                }));
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.note_alt,
                                      size: 64,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "ข้อมูลขอความช่วยเหลือในฐานข้อมูล",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  );
                }),
          )
        ],
      )),
    );
  }
}
