import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_database/Database/Editproduct.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class databaseproduct extends StatefulWidget {
  const databaseproduct({super.key, this.ip});
  final ip;

  @override
  State<databaseproduct> createState() => _databaseproductState();
}

class _databaseproductState extends State<databaseproduct> {
  Future getData() async {
    String url = "http://${widget.ip}/flutterdb/readproduct.php";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ฐานข้อมูลผลิตภัณฑ์',
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
                    return Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide())),
                      child: ListTile(
                        leading: GestureDetector(
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPageproduct(
                                    list: list,
                                    index: index,
                                    ip: widget.ip,
                                  ),
                                ));
                            Fluttertoast.showToast(msg: ' แก้ไขข้อมูล ');
                          },
                        ),
                        title: Text(
                          list[index]['product_name'],
                          style: GoogleFonts.aBeeZee(
                              fontSize: 24, color: Colors.black),
                        ),
                        subtitle: Text(
                          list[index]['product_exp'],
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        ),
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              String url =
                                  "http://${widget.ip}/flutterdb/deleteproduct.php";
                              http.post(Uri.parse(url), body: {
                                'id': list[index]['id'],
                              });
                              Fluttertoast.showToast(msg: ' ลบข้อมูล ');
                            });
                          },
                        ),
                      ),
                    );
                  }))
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
