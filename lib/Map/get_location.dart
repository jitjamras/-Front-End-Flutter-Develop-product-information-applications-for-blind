import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class get_location extends StatefulWidget {
  const get_location({Key? key, this.username, this.ip});
  final username;
  final ip;
  @override
  _get_locationState createState() => _get_locationState();
}

class _get_locationState extends State<get_location> {
  String location = 'Null, Press Button';
  String Address = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /*Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }*/

  TextEditingController username = TextEditingController();
  String gender = "";

  Future assistance_table(Position position, String gender) async {
    String url = "http://${widget.ip}/flutterdb/assistance.php";
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    final response = await http.post(Uri.parse(url), body: {
      'user_name': widget.username,
      'user_address': Address,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'request_gender': gender,
      'status_assistance': "",
    });
    var data = await json.decode(response.body);
    if (data == 'Error') {
      Fluttertoast.showToast(msg: "มีข้อผิดผลาดเกิดขึ้น");
    } else {
      Fluttertoast.showToast(msg: "คุณได้ขอความช่วยเหลือแล้ว");
    }
  }

  Future cancelassistance_table(Position position) async {
    String url = "http://${widget.ip}/flutterdb/cancelassistance.php";
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    final response = await http.post(Uri.parse(url), body: {
      'user_name': widget.username,
      'user_address': Address,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'status_assistance': "",
    });
    var data = await json.decode(response.body);
    if (data == 'Error') {
      Fluttertoast.showToast(msg: "มีข้อผิดผลาดเกิดขึ้น");
    } else {
      Fluttertoast.showToast(msg: "คุณได้ยกเลิกคำขอความช่วยเหลือแล้ว");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ขอความช่วยเหลือ',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffA96725)),
                      onPressed: () async {
                        Position position = await _getGeoLocationPosition();
                        location =
                            'Lat: ${position.latitude} , Long: ${position.longitude}';
                        gender = "ช/ญ";
                        assistance_table(position, gender);
                      },
                      child: Text(
                        'ขอความช่วยเหลือเกี่ยวกับ QR Code',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 24, color: Colors.black),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffA96725)),
                    onPressed: () async {
                      Position position = await _getGeoLocationPosition();
                      location =
                          'Lat: ${position.latitude} , Long: ${position.longitude}';
                      gender = "หญิง";
                      assistance_table(position, gender);
                    },
                    child: Text(
                      'ขอความช่วยเหลือเกี่ยวกับ QR Code ต้องการ ผู้หญิงเท่านั้น',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 24, color: Colors.black),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffA96725)),
                    onPressed: () async {
                      Position position = await _getGeoLocationPosition();
                      location =
                          'Lat: ${position.latitude} , Long: ${position.longitude}';
                      cancelassistance_table(position);
                    },
                    child: Text(
                      'ยกเลิกขอความช่วยเหลือ / ได้รับการช่วยเหลือแล้ว',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 24, color: Colors.black),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
