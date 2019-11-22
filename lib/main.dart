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
      title: 'Smart Society Staff',
      initialRoute: '/',
      routes: {
        '/': (context) => studentForm(),
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