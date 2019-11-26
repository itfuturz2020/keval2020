import 'dart:io';

import 'package:bss_admin/common/Services.dart';
import 'package:bss_admin/common/constant.dart' as cnst;
import 'package:bss_admin/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController txtMobile = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  ProgressDialog pr;

  @override
  void initState() {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: "Please Wait",
        borderRadius: 10.0,
        progressWidget: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(
            //backgroundColor: cnst.appPrimaryMaterialColor,
          ),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
  }

  showMsg(String msg, {String title = 'Smart Society'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  checkLogin() async {
    if (txtMobile.text != "" &&
        txtPassword.text != "") {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          pr.show();
          Future res = Services.Login(txtMobile.text, txtPassword.text);
          res.then((data) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (data != null && data.length > 0) {
              pr.hide();
              /*await prefs.setString(
                Session.MemberId,
                data[0]["Id"].toString(),
              );*/
              Navigator.pushReplacementNamed(context, '/dashBoard');
            } else {
              pr.hide();
              showMsg("Invalid login Detail.");
            }
          }, onError: (e) {
            pr.hide();
            print("Error : on Login Call $e");
            showMsg("$e");
          });
        } else {
          pr.hide();
          showMsg("No Internet Connection.");
        }
      } on SocketException catch (_) {
        showMsg("No Internet Connection.");
      }
    } else {
      showMsg("Please Fill All Details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.15,
            child: Image.asset(
              "images/cricket.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset('images/bss.png', height: 150, width: 150),
                  Text(
                    "BSS Sports Academy",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 85,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: TextFormField(
                        controller: txtMobile,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: cnst.fontColors),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_android),
                            labelText: "Enter Mobile Number",
                            counterText: "",
                            hasFloatingPlaceholder: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.amber,
                                    style: BorderStyle.solid,
                                    width: 2))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 20, right: 20),
                      child: TextFormField(
                        controller: txtPassword,
                        style: TextStyle(color: cnst.fontColors),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            labelText: "Enter Password",
                            hasFloatingPlaceholder: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.amber,
                                    style: BorderStyle.solid,
                                    width: 2))),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/dashBoard');
                          //checkLogin();
                        },
                        child: Text("LOGIN",
                            style: TextStyle(color: cnst.fontColors)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: cnst.appPrimaryMaterialColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
