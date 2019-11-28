import 'dart:io';

import 'package:bss_admin/common/Services.dart';
import 'package:bss_admin/components/PhotoComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class photos extends StatefulWidget {
  @override
  _photosState createState() => _photosState();
}

class _photosState extends State<photos> {
  List _allPhotos = [];
  bool isLoading = false;

  @override
  void initState() {
//    _getAllPhoto();
  }

  _getAllPhoto() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Future res = Services.GetAllPhotos();
        setState(() {
          isLoading = true;
        });
        res.then((data) async {
          if (data != null && data.length > 0) {
            setState(() {
              _allPhotos = data;
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
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

  showMsg(String msg, {String title = 'BSS Cricket'}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
      body: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(6),
        crossAxisCount: 4,
        itemCount: 12,//_allPhotos.length,
        itemBuilder: (BuildContext context, int index) {
          return PhotoComponent();
        },
        staggeredTileBuilder: (_) => StaggeredTile.fit(2),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
    );
  }
}
