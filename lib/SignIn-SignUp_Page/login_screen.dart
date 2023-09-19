import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/admin/dashboard_admin.dart';
import 'package:flutter_database/main.dart';
import 'package:flutter_database/SignIn-SignUp_Page/register_screen.dart';
import 'package:flutter_database/user/Handicapped/dashboard_Handicap.dart';
import 'package:flutter_database/user/Volunteer/dashboard_Volunteer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class login_screen extends StatefulWidget {
  const login_screen({super.key, this.ip});
  final ip;

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var isObsecure = true.obs;

  Future sign_in() async {
    String ip = widget.ip;
    String url = "http://$ip/flutterdb/login.php";
    final response = await http.post(Uri.parse(url), body: {
      'user_name': username.text,
      'user_password': password.text,
    });
    var data = await json.decode(response.body);
    if (data == 'จิตอาสา') {
      Fluttertoast.showToast(msg: "จิตอาสา เข้าสู่ระบบสำเร็จ");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard_Volunteer(username: username, ip: ip)));
    }
    if (data == 'ผู้พิการทางสายตา') {
      Fluttertoast.showToast(msg: "ผู้พิการทางสายตา เข้าสู่ระบบสำเร็จ");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard_Handicap(username: username, ip: ip)));
    }
    if (data == 'ADMIN') {
      Fluttertoast.showToast(msg: "ADMIN เข้าสู่ระบบสำเร็จ");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard_admin(
                    username: username,
                    ip: ip,
                  )));
    }
    if (data == 'Error') {
      Fluttertoast.showToast(msg: "ชื่อ Username / Password ผิด");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffEFB171),
      body: LayoutBuilder(builder: (context, cons) {
        return Column(
          children: [
            Container(
              child: Image.asset(
                "assets/images/eye-open.png",
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
            ),
            //login screen header

            //login screen sign-in form
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.679,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                    color: Color(0xffFFCF9F),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black,
                        offset: Offset(-2, -2),
                      )
                    ]
                    //borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //username-password-login button
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //username
                            TextFormField(
                              controller: username,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                labelText: "Username",
                                labelStyle: GoogleFonts.aBeeZee(
                                    fontSize: 20, color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Passwords obx เอาไว้ปิด-เปิดโชว์รหัสผ่าน
                            Obx(
                              () => TextFormField(
                                controller: password,
                                obscureText: isObsecure.value,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'กรุณากรอกรหัสผ่าน';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password_sharp,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: Obx(() => GestureDetector(
                                        onTap: () {
                                          isObsecure.value = !isObsecure.value;
                                        },
                                        child: Icon(
                                          isObsecure.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                      )),
                                  labelText: "Password",
                                  labelStyle: GoogleFonts.aBeeZee(
                                      fontSize: 20, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            //button Login
                            Container(
                              width: 200,
                              child: Material(
                                color: Color(0xffA96725),
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: () {
                                    bool pass =
                                        formKey.currentState!.validate();
                                    if (pass) {
                                      sign_in();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 28,
                                    ),
                                    child: Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.aBeeZee(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //don't have an account button - button
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            child: Material(
                              color: Color(0xffA96725),
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return register_screen(
                                      ip: widget.ip,
                                    );
                                  }));
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    "Register",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
