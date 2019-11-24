import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bss_admin/common/constant.dart' as cnst;

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.6,
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
                    onTap: () {},
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
        ],
      ),
    );
  }
}
