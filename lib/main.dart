import 'package:flutter/material.dart';
import 'package:flutter_database/Database/Editmember.dart';
import 'package:flutter_database/Database/dbmember.dart';
import 'package:flutter_database/Database/dbproduct.dart';
import 'package:flutter_database/Qrcode/Generate/upload_image_to_database.dart';
import 'package:flutter_database/SignIn-SignUp_Page/register_screen.dart';
import 'package:flutter_database/user/Handicapped/dashboard_Handicap.dart';
import 'package:flutter_database/user/Volunteer/Insert_info.dart';
import 'package:flutter_database/SignIn-SignUp_Page/login_screen.dart';

import 'Database/dbassistance.dart';
import 'Map/get_location.dart';
import 'Map/mark_location.dart';
import 'Qrcode/Generate/generate_qrcode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String nowip = "192.168.1.88";
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Test Database ',
        home: FutureBuilder(builder: (context, dataSnapShot) {
          return login_screen(
            ip: nowip,
          );
        }));
  }
}
