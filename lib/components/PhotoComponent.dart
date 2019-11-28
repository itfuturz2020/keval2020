import 'package:flutter/material.dart';
import 'package:bss_admin/common/constant.dart' as constant;

class PhotoComponent extends StatefulWidget {
  var photoData;

  //PhotoComponent(this.photoData);

  @override
  _PhotoComponentState createState() => _PhotoComponentState();
}

class _PhotoComponentState extends State<PhotoComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(widget.photoData["Image"]);
              }));
            },
            child:
                /*FadeInImage.assetNetwork(
            placeholder: "",
            image: constant.IMAGE_URL + '${widget.photoData["Image"]}',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),*/
                Image.asset(
              "images/cricket.jpg",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )),
      ),
    ));
  }
}

class DetailScreen extends StatelessWidget {
  String photo;

  DetailScreen(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Image.network(
            constant.IMAGE_URL + '$photo',
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
