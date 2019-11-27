import 'dart:io';

import 'package:bss_admin/common/Services.dart';
import 'package:bss_admin/common/classList.dart';
import 'package:bss_admin/components/LoadingComponent.dart';
import 'package:bss_admin/components/NoDataComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:bss_admin/common/constant.dart' as cnst;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class studentList extends StatefulWidget {
  @override
  _studentListState createState() => _studentListState();
}

class _studentListState extends State<studentList> {
  bool isLoading = false;
  List<courceClass> _courceClassList = [];
  List<batchClass> _batchClassList = [];
  List _studentList = [];

  courceClass _courceClass;
  batchClass _batchClass;

  bool isFirst = true;
  String _selectedAction = "";

  ProgressDialog pr;

  @override
  void initState() {
    _getCourceData();
    _getBatchData();
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: "Please Wait",
        borderRadius: 10.0,
        progressWidget: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
  }

  _getCourceData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future res = Services.getCource();
        setState(() {
          isLoading = true;
        });
        res.then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data != null) {
            setState(() {
              isLoading = false;
              _courceClassList = data;
            });
          } else {
            setState(() {
              isLoading = false;
              _courceClassList = data;
            });
          }
        }, onError: (e) {
          showMsg("$e");
          setState(() {
            isLoading = false;
          });
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  _getBatchData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future res = Services.getBatch();
        setState(() {
          isLoading = true;
        });
        res.then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data != null) {
            setState(() {
              isLoading = false;
              _batchClassList = data;
            });
          } else {
            setState(() {
              isLoading = false;
              _batchClassList = data;
            });
          }
        }, onError: (e) {
          showMsg("$e");
          setState(() {
            isLoading = false;
          });
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  getStudentData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        Future res = Services.GetStudent(_courceClass.id, _batchClass.id);
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              _studentList = data;
              isFirst = false;
            });
            pr.hide();
          } else {
            pr.hide();
          }
        }, onError: (e) {
          pr.hide();
          showMsg("$e");
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
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
        title: Text("Student List"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/studentForm");
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 3, right: 3, top: 2, bottom: 2),
                      child: Text(
                        "Add\nStudent",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ))),
          )
        ],
      ),
      body: isLoading
          ? LoadingComponent()
          : Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 45,
                            child: InputDecorator(
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10),
                                  )),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<courceClass>(
                                hint: _courceClassList != null &&
                                        _courceClassList != "" &&
                                        _courceClassList.length > 0
                                    ? Text("Select Cource Type",
                                        style: TextStyle(
                                          fontSize: 13,
                                        ))
                                    : Text(
                                        "Cource Not Found",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                value: _courceClass,
                                onChanged: (val) {
                                  setState(() {
                                    _courceClass = val;
                                  });
                                },
                                items:
                                    _courceClassList.map((courceClass cources) {
                                  return DropdownMenuItem<courceClass>(
                                    value: cources,
                                    child: Text(
                                      cources.name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    ),
                                  );
                                }).toList(),
                              )),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 6)),
                          SizedBox(
                            height: 45,
                            child: InputDecorator(
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10),
                                  )),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<batchClass>(
                                hint: _batchClassList != null &&
                                        _batchClassList != "" &&
                                        _batchClassList.length > 0
                                    ? Text("Select Batch",
                                        style: TextStyle(
                                          fontSize: 13,
                                        ))
                                    : Text("Batch Not Found",
                                        style: TextStyle(
                                          fontSize: 13,
                                        )),
                                value: _batchClass,
                                onChanged: (val) {
                                  setState(() {
                                    _batchClass = val;
                                  });
                                },
                                items: _batchClassList.map((batchClass batch) {
                                  return DropdownMenuItem<batchClass>(
                                    value: batch,
                                    child: Text(
                                      batch.name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    ),
                                  );
                                }).toList(),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 75,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            getStudentData();
                          },
                          child: Text("Go",
                              style: TextStyle(color: cnst.fontColors)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: cnst.appPrimaryMaterialColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                isFirst
                    ? Container()
                    : _studentList.length > 0
                        ? Expanded(
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: _studentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  margin: EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        ClipOval(
                                            child: _studentList[index]
                                                            ["Photo"] !=
                                                        null &&
                                                    _studentList[index]
                                                            ["Photo"] !=
                                                        ""
                                                ? FadeInImage.assetNetwork(
                                                    placeholder: '',
                                                    image: "http://bss.mobwebit.com/" +
                                                        "${_studentList[index]["Photo"]}",
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.fill)
                                                : Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                        color: cnst
                                                            .appPrimaryMaterialColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
                                                    child: Center(
                                                      child: Text(
                                                        "${_studentList[index]["Name"].toString().substring(0, 1).toUpperCase()}",
                                                        style: TextStyle(
                                                            fontSize: 26,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 4)),
                                        Text(
                                          "${_studentList[index]["Id"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${_studentList[index]["Name"]}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: cnst.fontColors),
                                        ),
                                        Text(
                                          "${_studentList[index]["CourceName"]}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                launch("tel:" +
                                                    _studentList[index]
                                                            ["FatherMobile"]
                                                        .toString());
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Opacity(
                                                    child: Container(
                                                      width: 37,
                                                      height: 37,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50))),
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                    opacity: 0.15,
                                                  ),
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.green[700],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Opacity(
                                                  child: Container(
                                                    width: 37,
                                                    height: 37,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.blueAccent,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
                                                    alignment: Alignment.center,
                                                  ),
                                                  opacity: 0.15,
                                                ),
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.blueAccent,
                                                ),
                                              ],
                                            ),
                                            PopupMenuButton<String>(
                                              onSelected: (String value) {
                                                setState(() {
                                                  _selectedAction = value;
                                                });
                                                print(value+index.toString());
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Opacity(
                                                    child: Container(
                                                      width: 37,
                                                      height: 37,
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50))),
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                    opacity: 0.15,
                                                  ),
                                                  Icon(
                                                    Icons.more_horiz,
                                                    color: Colors.orange,
                                                  ),
                                                ],
                                              ),
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: 'Edit',
                                                  child: Text('Edit'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'Delete',
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                            ),
                          )
                        : NoDataComponent(),
              ],
            ),
    );
  }
}
