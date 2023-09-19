import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class register_screen extends StatefulWidget {
  const register_screen({super.key, this.ip});
  final ip;

  @override
  State<register_screen> createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  String gender = '';
  String status = '';

  String item = 'จิตอาสา';
  List items = ['จิตอาสา', 'ผู้พิการทางสายตา'];

  String sex = 'ชาย';
  final sexs = ['ชาย', 'หญิง'];

  var isObsecure = true.obs;

  Future sign_up() async {
    String url = "http://${widget.ip}/flutterdb/register.php";
    final response = await http.post(Uri.parse(url), body: {
      'user_name': username.text,
      'user_password': password.text,
      'first_name': firstname.text,
      'last_name': lastname.text,
      'phone_number': phonenumber.text,
      'user_email': email.text,
      'user_gender': gender,
      'user_status': status,
    });
    var data = await json.decode(response.body);
    if (data == 'Error') {
      Fluttertoast.showToast(msg: "มี Username นี้อยู่ในระบบแล้ว");
    } else {
      Fluttertoast.showToast(msg: "ลงทะเบียนสำเร็จ");
    }
  }

  /*validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': email.text.trim(),
        },
      );
      if (res.statusCode ==
          200) // from flutter app the connection with api to server - success
      {
        var resBodyOfValidateEmail = jsonDecode(res.body);
        var resBody = jsonDecode(res.body);
        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(
              msg: "Email is already in someone else use. Try another email.");
        } else {
          //register & save new user record to database
          registerAndSaveUserRecord();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveUserRecord() async {
    User userModel = User(1, username.text.trim(), password.text.trim(),
        firstname.text.trim(), lastname.text.trim(), email.text.trim());
    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );
      if (res.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(res.body);
        if (resBodyOfSignUp['success'] == true) {
          Fluttertoast.showToast(msg: "SignUp Successfully.");
        } else {
          Fluttertoast.showToast(msg: "Error Occurred, Try Again.");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',
            style: GoogleFonts.aBeeZee(fontSize: 24, color: Colors.black)),
        backgroundColor: Color(0xffC57F45),
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
      backgroundColor: Color(0xffEBA972),
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //register screen sign-in form
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                      child: Column(
                        children: [
                          Text(
                            "Register",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //register textformfield
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                //Username Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกชื่อผู้ใช้';
                                    }
                                    return null;
                                  },
                                  controller: username,
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
                                SizedBox(
                                  height: 20,
                                ),
                                //Passwords Box
                                Obx(
                                  () => TextFormField(
                                    obscureText: isObsecure.value,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'กรุณากรอกรหัสผ่าน';
                                      }
                                      return null;
                                    },
                                    controller: password,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Obx(() => GestureDetector(
                                            onTap: () {
                                              isObsecure.value =
                                                  !isObsecure.value;
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.black)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.black)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                SizedBox(
                                  height: 20,
                                ),
                                //Firstname Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกชื่อ';
                                    }
                                    return null;
                                  },
                                  controller: firstname,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_2_rounded,
                                      color: Colors.black,
                                    ),
                                    labelText: "Firstname",
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
                                SizedBox(
                                  height: 20,
                                ),
                                //Lastname Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกนามสกุล';
                                    }
                                    return null;
                                  },
                                  controller: lastname,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_2_rounded,
                                      color: Colors.black,
                                    ),
                                    labelText: "Lastname",
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
                                SizedBox(
                                  height: 20,
                                ),
                                //Phonenumber Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกเบอร์โทรศัพท์';
                                    }
                                    return null;
                                  },
                                  controller: phonenumber,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                    labelText: "Phonenumber",
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
                                SizedBox(
                                  height: 15,
                                ),
                                //Email Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกอีเมล์';
                                    }
                                    return null;
                                  },
                                  controller: email,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    labelText: "Email",
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
                                SizedBox(
                                  height: 15,
                                ),
                                //Gender Dropdowbutton
                                Row(
                                  children: [
                                    Text(
                                      "Gender : ",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 24, color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),

                                      // dropdown below..
                                      child: DropdownButton<String>(
                                        alignment: Alignment.center,
                                        value: sex,
                                        onChanged: (value) => setState(
                                          () => sex = value.toString(),
                                        ),
                                        items: sexs
                                            .map<DropdownMenuItem<String>>(
                                                (String value) =>
                                                    DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                                fontSize: 18),
                                                      ),
                                                    ))
                                            .toList(),
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 42,
                                        underline: SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //Status DropdownButton
                                Row(
                                  children: [
                                    Text(
                                      "Status : ",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 24, color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DropdownButton(
                                        alignment: Alignment.center,
                                        dropdownColor: Colors.white,
                                        value: item,
                                        items: items
                                            .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: GoogleFonts.aBeeZee(
                                                      fontSize: 18),
                                                )))
                                            .toList(),
                                        onChanged: (value) => setState(
                                          () => item = value.toString(),
                                        ),
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 42,
                                        underline: SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //Register Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffA96725)),
                                  onPressed: () => setState(() {
                                    bool pass =
                                        formKey.currentState!.validate();
                                    if (pass) {
                                      status = item.toString();
                                      gender = sex.toString();
                                      sign_up();
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return login_screen(
                                          ip: widget.ip,
                                        );
                                      }));
                                    }
                                  }),
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
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
