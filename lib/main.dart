import 'package:bss_admin/screens/dashBoard.dart';
import 'package:bss_admin/screens/login.dart';
import 'package:bss_admin/screens/splash.dart';
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
        '/studentForm': (context) => studentForm(),
        '/dashBoard': (context) => dashBoard(),
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
