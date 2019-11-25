import 'package:bss_admin/common/constant.dart' as cnst;
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController txtMobile = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

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
                          Navigator.pushReplacementNamed(context, "/dashBoard");
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
