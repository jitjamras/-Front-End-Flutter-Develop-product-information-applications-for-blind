import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/Database/dbmember.dart';
import 'package:flutter_database/Database/dbproduct.dart';
import 'package:flutter_database/admin/dashboard_admin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditPageproduct extends StatefulWidget {
  const EditPageproduct({
    super.key,
    required this.list,
    required this.index,
    this.ip,
  });
  final List list;
  final int index;
  final ip;

  @override
  State<EditPageproduct> createState() => _EditPageproductState();
}

class _EditPageproductState extends State<EditPageproduct> {
  var formKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productExp = TextEditingController();
  TextEditingController productInfo = TextEditingController();
  TextEditingController productNote = TextEditingController();
  bool editMode = false;

  Future addUpdateData() async {
    if (editMode) {
      String url = "http://${widget.ip}/flutterdb/editproduct.php";
      http.post(Uri.parse(url), body: {
        'id': widget.list[widget.index]['id'],
        'product_name': productName.text,
        'product_exp': productExp.text,
        'product_info': productInfo.text,
        'product_note': productNote.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      productName.text = widget.list[widget.index]['product_name'];
      productExp.text = widget.list[widget.index]['product_exp'];
      productInfo.text = widget.list[widget.index]['product_info'];
      productNote.text = widget.list[widget.index]['product_note'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Product',
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
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 30, 30, 8),
                                  child: Container(
                                    child: Text(
                                      "Update Product",
                                      style: GoogleFonts.aBeeZee(fontSize: 30),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                //Product_name Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกชื่อผลิตภัณฑ์';
                                    }
                                    return null;
                                  },
                                  controller: productName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.production_quantity_limits,
                                      color: Colors.black,
                                    ),
                                    labelText: "Product_name",
                                    labelStyle: GoogleFonts.aBeeZee(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
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
                                //Date_exp Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกวันหมดอายุ';
                                    }
                                    return null;
                                  },
                                  controller: productExp,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.black,
                                    ),
                                    labelText: "Date_exp",
                                    labelStyle: GoogleFonts.aBeeZee(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
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
                                //product_info Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกข้อมูลผลิตภัณฑ์';
                                    }
                                    return null;
                                  },
                                  controller: productInfo,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.info,
                                      color: Colors.black,
                                    ),
                                    labelText: "product_info",
                                    labelStyle: GoogleFonts.aBeeZee(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
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
                                //Other Box
                                TextFormField(
                                  controller: productNote,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.more,
                                      color: Colors.black,
                                    ),
                                    labelText: "Other or more",
                                    labelStyle: GoogleFonts.aBeeZee(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
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
                                  height: 30,
                                ),
                                //Save Button
                                Container(
                                  width: 200,
                                  child: Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        bool pass =
                                            formKey.currentState!.validate();
                                        if (pass) {
                                          addUpdateData();
                                          Fluttertoast.showToast(
                                              msg: "Update Finish");
                                          Navigator.pop(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return databaseproduct(
                                              ip: widget.ip,
                                            );
                                          }));
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          editMode ? 'Update' : "Save",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
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
