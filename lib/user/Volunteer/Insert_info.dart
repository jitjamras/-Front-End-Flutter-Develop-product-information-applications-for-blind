import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class Insert_info extends StatefulWidget {
  const Insert_info({super.key});

  @override
  State<Insert_info> createState() => _Insert_infoState();
}

class _Insert_infoState extends State<Insert_info> {
  var formKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productExp = TextEditingController();
  TextEditingController productInfo = TextEditingController();
  TextEditingController productNote = TextEditingController();

  Future save_info() async {
    String url = "http://172.16.152.98/flutterdb/product_infomation.php";
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
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //register screen header
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.asset("assets/images/register_icon.png"),
                ),
                //register screen sign-in form
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          /*BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          )*/
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                      child: Column(
                        children: [
                          //email-productExp-login button
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                //Product_name Box
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Empty';
                                    }
                                    return null;
                                  },
                                  controller: productName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.production_quantity_limits_outlined,
                                      color: Colors.black,
                                    ),
                                    hintText: "Product_name",
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
                                      return 'Empty';
                                    }
                                    return null;
                                  },
                                  controller: productExp,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.black,
                                    ),
                                    hintText: "Date_exp",
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
                                      return 'Empty';
                                    }
                                    return null;
                                  },
                                  controller: productInfo,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.text_decrease,
                                      color: Colors.black,
                                    ),
                                    hintText: "product_info",
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
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Empty';
                                    }
                                    return null;
                                  },
                                  controller: productNote,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.more,
                                      color: Colors.black,
                                    ),
                                    hintText: "Other or more",
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
                                          save_info();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          "Save",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
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
