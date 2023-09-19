import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/Database/dbassistance.dart';
import 'package:flutter_database/Qrcode/Generate/upload_image_to_database.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';
import 'package:flutter_database/main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Qrcode/Generate/generate_qrcode.dart';
import '../../Qrcode/Scanner/Scanner_QR.dart';

class Dashboard_Volunteer extends StatefulWidget {
  const Dashboard_Volunteer({super.key, this.username, this.ip});
  final username;
  final ip;
  @override
  State<Dashboard_Volunteer> createState() => _Dashboard_VolunteerState();
}

class _Dashboard_VolunteerState extends State<Dashboard_Volunteer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: GoogleFonts.aBeeZee(color: Colors.black)),
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
                  "Username ",
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
            padding: const EdgeInsets.only(top: 12, left: 5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        bottomLeft: Radius.circular(90)),
                    color: Color(0xffFFCF9F),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black,
                        offset: Offset(-2, -2),
                      )
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffA96725)),
                                    onPressed: () {
                                      {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GenerateQRCode(
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
                                              Icons.qr_code_2_outlined,
                                              size: 64,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "สร้าง QR Code",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.aBeeZee(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: //Box 2 (สแกน QR Code)
                                  Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffA96725)),
                                    onPressed: () {
                                      {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return QRCodeScanner();
                                        }));
                                      }
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.scanner,
                                              size: 64,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "สแกน QR Code",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.aBeeZee(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: //Box 3 (แผนที่ผู้พิการทางสายตา)
                                  Container(
                                width: 200,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffA96725)),
                                    onPressed: () {
                                      {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return databaseassistance(
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
                                              Icons.map,
                                              size: 64,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "คำขอความช่วยเหลือจากผู้พิการทางสายตา",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.aBeeZee(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )),
          ),
        ],
      )),
    );
  }
}
