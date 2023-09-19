import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/Qrcode/Generate/share_qr_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key, this.ip});
  final ip;

  @override
  GenerateQRCodeState createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  var formKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productExp = TextEditingController();
  TextEditingController productInfo = TextEditingController();
  TextEditingController productNote = TextEditingController();

  Future save_info() async {
    String url = "http://${widget.ip}/flutterdb/product_infomation.php";
    final response = await http.post(Uri.parse(url), body: {
      'product_name': productName.text,
      'product_exp': productExp.text,
      'product_info': productInfo.text,
      'product_note': productNote.text,
    });
    var data = await json.decode(response.body);
    if (data == 'Error') {
      Fluttertoast.showToast(msg: "บันทึกข้อมูลไม่สำเร็จ");
    } else {
      Fluttertoast.showToast(msg: "บันทึกข้อมูลสำเร็จ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้าง QR Code',
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
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "กรอกข้อมูลของผลิตภัณฑ์",
              style: GoogleFonts.aBeeZee(fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: productName,
              decoration: InputDecoration(
                labelText: 'ชื่อผลิตภัณฑ์',
                labelStyle: GoogleFonts.aBeeZee(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: productExp,
              decoration: InputDecoration(
                hintText: "เช่น : 18/8/2023",
                labelText: 'วันหมดอายุ ',
                labelStyle: GoogleFonts.aBeeZee(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: productInfo,
              decoration: InputDecoration(
                labelText: 'ข้อมูลผลิตภัณฑ์',
                labelStyle: GoogleFonts.aBeeZee(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: productNote,
              decoration: InputDecoration(
                labelText: 'หมายเหตุ/เพิ่มเติม',
                labelStyle: GoogleFonts.aBeeZee(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  save_info();
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => SharQR_Code(
                          textQrCode: " ชื่อผลิตภัณฑ์ " +
                              productName.text +
                              " วันหมดอายุ " +
                              productExp.text +
                              " ข้อมูลผลิตภัณฑ์ " +
                              productInfo.text +
                              " หมายเหตุ/เพิ่มเติม " +
                              productNote.text.trim())));
                },
                child: Container(
                  height: 50,
                  color: Color(0xffA96725),
                  child: const Center(
                    child: Text(
                      "สร้าง QR Code",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
