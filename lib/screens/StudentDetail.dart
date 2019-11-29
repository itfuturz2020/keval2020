import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bss_admin/common/constant.dart' as cnst;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDetail extends StatefulWidget {
  var studentData;

  StudentDetail({this.studentData});

  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<Tab> tabList = List();

  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Basic',
    ));
    tabList.add(new Tab(
      text: 'Fees Detail',
    ));
    tabList.add(new Tab(
      text: 'Attendance',
    ));
    tabList.add(new Tab(
      text: 'Gallary',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String setDate(String date) {
    String final_date = "";
    var tempDate;
    if (date != "" || date != null) {
      tempDate = date.split("-");
      if (tempDate[2].toString().length == 1) {
        tempDate[2] = "0" + tempDate[2].toString();
      }
      if (tempDate[1].toString().length == 1) {
        tempDate[1] = "0" + tempDate[1].toString();
      }
    }
    final_date = date == "" || date == null
        ? ""
        : "${tempDate[2].toString().substring(0, 2)}-${tempDate[1].toString()}-${tempDate[0].toString()}"
            .toString();

    return final_date;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, "/studentList");
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student Details"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/studentList");
              }),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: widget.studentData["Photo"] != "" &&
                                  widget.studentData["Photo"] != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: "images/student_placeholder.png",
                                  image: cnst.IMAGE_URL +
                                      '${widget.studentData["Photo"]}',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  "images/student_placeholder.png",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${widget.studentData["Name"]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: cnst.fontColors)),
                            Padding(padding: EdgeInsets.only(top: 13)),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    launch("tel:" +
                                        widget.studentData["FatherMobile"]
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          alignment: Alignment.center,
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
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Opacity(
                                      child: Container(
                                        width: 37,
                                        height: 37,
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
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
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35.0, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${widget.studentData["PracticeType"]}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: cnst.fontColors,
                                      fontWeight: FontWeight.w600)),
                              Text("PRACTICE TYPE",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                              width: 110,
                              height: 70,
                              color: Colors.grey[300],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("${widget.studentData["CoachingType"]}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: cnst.fontColors,
                                          fontWeight: FontWeight.w600)),
                                  Text("COACHING TYPE",
                                      style: TextStyle(fontSize: 11)),
                                ],
                              )),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            width: 100,
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    widget.studentData["JoinDate"] != null &&
                                            widget.studentData["JoinDate"] != ""
                                        ? "${setDate(widget.studentData["JoinDate"])}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: cnst.fontColors,
                                        fontWeight: FontWeight.w600)),
                                Text("DATE OF JOIN",
                                    style: TextStyle(fontSize: 11)),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Column(
              children: <Widget>[
                new Container(
                  child: new TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          padding: EdgeInsets.only(
                              left: 17, right: 17, top: 10, bottom: 10),
                          child: Text("Basic",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                      Text("Fees Detail"),
                      Text("Attendance"),
                      Text("Gallary"),
                    ],
                  ),
                ),
                new Container(
                  height: 40.0,
                  child: new TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Container(
                        child: Center(child: Text("Basic")),
                      ),
                      Container(
                        child: Center(child: Text("Fees Detail")),
                      ),
                      Container(
                        child: Center(child: Text("Attendance")),
                      ),
                      Container(
                        child: Center(child: Text("Gallary")),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
