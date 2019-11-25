import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:bss_admin/common/constant.dart' as cnst;

class studentList extends StatefulWidget {
  @override
  _studentListState createState() => _studentListState();
}

class _studentListState extends State<studentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      "images/my_photo.jpeg",
                      width: 70,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 4)),
                  Text(
                    "102",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Chirag Mevada",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: cnst.fontColors),
                  ),
                  Text(
                    "Cricket",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Opacity(
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
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
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Opacity(
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
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
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Opacity(
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              alignment: Alignment.center,
                            ),
                            opacity: 0.15,
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (_) => StaggeredTile.fit(2),
      ),
    );
  }
}
