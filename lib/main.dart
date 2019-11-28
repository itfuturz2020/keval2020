import 'package:bss_admin/screens/StudentDetail.dart';
import 'package:bss_admin/screens/dashBoard.dart';
import 'package:bss_admin/screens/employeeList.dart';
import 'package:bss_admin/screens/feesDetail.dart';
import 'package:bss_admin/screens/login.dart';
import 'package:bss_admin/screens/photos.dart';
import 'package:bss_admin/screens/salaryDetail.dart';
import 'package:bss_admin/screens/splash.dart';
import 'package:bss_admin/screens/studentList.dart';
import 'package:bss_admin/screens/videos.dart';
import 'package:flutter/material.dart';

import 'common/constant.dart';
import 'screens/studentForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BSS Sports Acedamy',
      initialRoute: '/',
      routes: {
        '/': (context) => splash(),
        '/login': (context) => login(),
        '/dashBoard': (context) => dashBoard(),
        '/studentForm': (context) => studentForm(),
        '/employeeList': (context) => employeeList(),
        '/videos': (context) => videos(),
        '/photos': (context) => photos(),
        '/feesDetail': (context) => feesDetail(),
        '/salaryDetail': (context) => salaryDetail(),
        '/studentList': (context) => studentList(),
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: appPrimaryMaterialColor,
        accentColor: appPrimaryMaterialColor,
        buttonColor: Colors.deepPurple,
      ),
    );
  }
}
