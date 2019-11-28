import 'dart:io';

//import 'package:barcode_scan/barcode_scan.dart';
import 'package:bss_admin/common/Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bss_admin/common/constant.dart' as cnst;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  String barcode = "";

  ProgressDialog pr;

  List _menuList = [
    {
      "image": "images/student_list.png",
      "title": "Student List",
      "color": 0xff2A3565,
      "screen": "studentList"
    },
    {
      "image": "images/employee.png",
      "title": "Employee List",
      "color": 0xffFF5400,
      "screen": "employeeList"
    },
    {
      "image": "images/youtube.png",
      "title": "Videos",
      "color": 0xffF61C0D,
      "screen": "videos"
    },
    {
      "image": "images/add_photo.png",
      "title": "Photos",
      "color": 0xff3E7500,
      "screen": "photos"
    },
    {
      "image": "images/salary.png",
      "title": "Fees Detail",
      "color": 0xff3BB54A,
      "screen": "feesDetail"
    },
    {
      "image": "images/salary.png",
      "title": "Salary Detail",
      "color": 0xff3BB54A,
      "screen": "salaryDetail"
    },
  ];

  @override
  void initState() {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: "Please Wait",
        borderRadius: 10.0,
        progressWidget: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(
            backgroundColor: cnst.appPrimaryMaterialColor,
          ),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
  }

  _addStudent(String studID) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.SaveStudentByScan(studID).then((data) async {
          pr.hide();
          if (data.Data != "0" && data.IsSuccess == true) {
            Fluttertoast.showToast(
                msg: "Attendace Saved Successfully",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacementNamed(context, "/studentList");
          } else {
            showMsg(data.Message, title: "Error");
          }
        }, onError: (e) {
          pr.hide();
          showMsg("Try Again.");
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      pr.hide();
      showMsg("No Internet Connection.");
    }
  }

  showMsg(String msg, {String title = 'BSS Sports Academy'}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chirag Mevada",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: cnst.fontColors)),
        leading: Icon(
          Icons.person_outline,
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
            Navigator.pushReplacementNamed(context, "/login");
          })
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
                color: cnst.appPrimaryMaterialColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/bss.png', height: 50, width: 50),
                Text(
                  "BSS Sports Academy",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: cnst.fontColors),
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          Expanded(
            child: GridView.builder(
                itemCount: _menuList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2.5),
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, "/${_menuList[index]["screen"]}");
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 7, bottom: 7),
                      child: Container(
                        width: 140,
                        height: 120,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Opacity(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Color(_menuList[index]["color"]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    alignment: Alignment.center,
                                  ),
                                  opacity: 0.15,
                                ),
                                Image.asset('${_menuList[index]["image"]}',
                                    height: 36, width: 36),
                              ],
                              alignment: Alignment.center,
                            ),
                            Text(
                              "${_menuList[index]["title"]}",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: cnst.fontColors,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Icon(
                        Icons.filter_center_focus,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: cnst.fontColors,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
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

/*  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
      if (barcode != null) {
        _addStudent(barcode);
      } else
        showMsg("Try Again..");
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }*/
}
