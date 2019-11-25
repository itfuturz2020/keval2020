import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
            child: Text("aa"),
          );
        },
        staggeredTileBuilder: (_) => StaggeredTile.fit(2),
      ),
    );
  }
}
