import 'package:flutter/material.dart';

class employeeList extends StatefulWidget {
  @override
  _employeeListState createState() => _employeeListState();
}

class _employeeListState extends State<employeeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
    );
  }
}
