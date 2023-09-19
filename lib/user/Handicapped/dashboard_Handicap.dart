import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/Map/get_location.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';
import 'package:flutter_database/main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Qrcode/Scanner/Scanner_QR_for_Handicapped.dart';

class Dashboard_Handicap extends StatefulWidget {
  const Dashboard_Handicap({super.key, this.username, this.ip});
  final username;
  final ip;
  @override
  State<Dashboard_Handicap> createState() => _Dashboard_HandicapState();
}

class _Dashboard_HandicapState extends State<Dashboard_Handicap> {
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                          return QRCodeScan_Handicap();
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
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Text(
                                              "สแกน QR Code",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
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
                            padding: const EdgeInsets.all(12.0),
                            child: Expanded(
                                child: //Box 2 (สแกน QR Code)
                                    Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xffA96725)),
                                  onPressed: () {
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  get_location(
                                                    username:
                                                        widget.username.text,
                                                    ip: widget.ip,
                                                  )));
                                    }
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.handshake,
                                            size: 64,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Text(
                                            "ขอความช่วยเหลือจากจิตอาสา",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
