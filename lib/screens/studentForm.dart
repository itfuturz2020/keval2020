import 'dart:io';

import 'package:bss_admin/common/Services.dart';
import 'package:bss_admin/common/classList.dart';
import 'package:bss_admin/common/constant.dart';
import 'package:bss_admin/common/constant.dart' as cnst;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class studentForm extends StatefulWidget {
  @override
  _studentFormState createState() => _studentFormState();
}

class _studentFormState extends State<studentForm> {
  List<courceClass> _courceClassList = [];
  bool isLoading = false;

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtFatherName = new TextEditingController();
  TextEditingController txtMotherName = new TextEditingController();
  TextEditingController txtFatherMobile = new TextEditingController();
  TextEditingController txtMotherMobile = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();

  courceClass _courceClass;
  File _studentImage;
  String _fileName;
  String _path;
  bool _loadingPath = false;
  bool _hasValidMime = false;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;

  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;
  ProgressDialog pr;

  @override
  void initState() {
    _dateTime = DateTime.now();
    _getCourceData();
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

  _getCourceData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future res = Services.getCource();
        pr.show();
        res.then((data) async {
          pr.hide();
          if (data != null) {
            setState(() {
              _courceClassList = data;
            });
          } else {
            setState(() {
              _courceClassList = data;
            });
          }
        }, onError: (e) {
          showMsg("$e");
          pr.hide();
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
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg),
          actions: <Widget>[
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

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('Done', style: TextStyle(color: Colors.red)),
        cancel: Text('cancel', style: TextStyle(color: Colors.cyan)),
      ),
      initialDateTime: DateTime.now(),
      dateFormat: _format,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );
  }

  void _imagePopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (image != null)
                        setState(() {
                          _path = '';
                          _fileName = '';
                          _studentImage = image;
                        });
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: new Icon(Icons.photo),
                    title: new Text('Gallery'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null)
                        setState(() {
                          _path = '';
                          _fileName = '';
                          _studentImage = image;
                        });
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  _addStudent() async {
    if (txtName.text != null &&
        txtFatherName.text != '' &&
        txtFatherMobile.text != null &&
        txtMotherName.text != '' &&
        txtMotherMobile.text != '' &&
        txtAddress.text != '' &&
        _courceClass != null) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          String filename = "";
          String filePath = "";
          File compressedFile;
          pr.show();

          if (_studentImage != null) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(_studentImage.path);

            compressedFile = await FlutterNativeImage.compressImage(
              _studentImage.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round(),
            );

            filename = _studentImage.path.split('/').last;
            filePath = compressedFile.path;
          } else if (_path != null && _path != '') {
            filePath = _path;
            filename = _fileName;
          }

          FormData formData = new FormData.fromMap({
            "Id": 0,
            "Name": txtName.text,
            "FatherName": txtFatherName.text,
            "FatherMobile": txtFatherMobile.text,
            "MotherName": txtMotherName.text,
            "MotherMobile": txtMotherMobile.text,
            "Address": txtAddress.text,
            "CourceId": _courceClass.id,
            "JoinDate": _dateTime.toString(),
            "Image": (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                    filename: filename.toString())
                : null
          });

          Services.SaveStudent(formData).then((data) async {
            pr.hide();
            if (data.Data != "0" && data.IsSuccess == true) {
              _clearData();
              showMsg("Student Saved Successfully", title: "Success");
            } else {
              _clearData();
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
    } else {
      showMsg("Please Fill All Data.", title: "Alert !");
    }
  }

  _clearData() {
    setState(() {
      txtName.text = "";
      txtFatherName.text = "";
      txtFatherMobile.text = "";
      txtMotherName.text = "";
      txtMotherMobile.text = "";
      txtAddress.text = "";
      _studentImage = null;
      _courceClass = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, "/studentList");
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student Form"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/studentList");
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                txtName.text == "" &&
                        txtFatherName.text == "" &&
                        txtFatherMobile.text == "" &&
                        txtMotherName.text == "" &&
                        txtMotherMobile.text == "" &&
                        txtAddress.text == "" &&
                        _studentImage == null &&
                        _courceClass == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          _clearData();
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 100,
                            height: 40,
                            padding: EdgeInsets.only(left: 7, right: 7),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.clear,
                                  size: 22,
                                ),
                                Text(
                                  "Clear All",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        child: InputDecorator(
                          decoration: new InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10),
                              )),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<courceClass>(
                            hint: _courceClassList != null &&
                                    _courceClassList != "" &&
                                    _courceClassList.length > 0
                                ? Text("Select Cource Type")
                                : Text(
                                    "Cource Not Found",
                                    style: TextStyle(fontSize: 14),
                                  ),
                            value: _courceClass,
                            onChanged: (val) {
                              setState(() {
                                _courceClass = val;
                              });
                            },
                            items: _courceClassList.map((courceClass cources) {
                              return DropdownMenuItem<courceClass>(
                                value: cources,
                                child: Text(
                                  cources.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          )),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        child: InputDecorator(
                          decoration: new InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10),
                              )),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<courceClass>(
                                hint: _courceClassList != null &&
                                    _courceClassList != "" &&
                                    _courceClassList.length > 0
                                    ? Text("Select Cource Type")
                                    : Text(
                                  "Cource Not Found",
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: _courceClass,
                                onChanged: (val) {
                                  setState(() {
                                    _courceClass = val;
                                  });
                                },
                                items: _courceClassList.map((courceClass cources) {
                                  return DropdownMenuItem<courceClass>(
                                    value: cources,
                                    child: Text(
                                      cources.name,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                      ),
                    ),
                  ],
                ), Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: txtName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        labelText: "Student Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: cnst.appPrimaryMaterialColor,
                                style: BorderStyle.solid,
                                width: 3))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: txtFatherName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_add),
                        labelText: "Father Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: cnst.appPrimaryMaterialColor,
                                style: BorderStyle.solid,
                                width: 3))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: txtFatherMobile,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.perm_phone_msg),
                        labelText: "Father Mobile No",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: cnst.appPrimaryMaterialColor,
                                style: BorderStyle.solid,
                                width: 3))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: txtMotherName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_add),
                        labelText: "Mother Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: cnst.appPrimaryMaterialColor,
                                style: BorderStyle.solid,
                                width: 3))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: txtMotherMobile,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Mother Mobile No",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: cnst.appPrimaryMaterialColor,
                                style: BorderStyle.solid,
                                width: 3))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: txtAddress,
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance),
                        labelText: "Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: cnst.appPrimaryMaterialColor,
                                style: BorderStyle.solid,
                                width: 3))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showDatePicker();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Joint Date: ${_dateTime.toString().substring(8, 10)}-${_dateTime.toString().substring(5, 7)}-${_dateTime.toString().substring(0, 4)}",
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _imagePopup(context);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 50,
                            width: 150,
                            padding: EdgeInsets.only(left: 7, right: 7),
                            decoration: BoxDecoration(
                              color: appPrimaryMaterialColor[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Student Photo",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    _studentImage != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Image.file(
                              File(_studentImage.path),
                              height: 160,
                              width: 130,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.topRight,
                      child: _studentImage != null
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _studentImage = null;
                                });
                              })
                          : Container(),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    onPressed: () {
                      _addStudent();
                    },
                    color: appPrimaryMaterialColor[700],
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.save,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
