import 'package:flutter/material.dart';

class photos extends StatefulWidget {
  @override
  _photosState createState() => _photosState();
}

class _photosState extends State<photos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
    );
  }
}
