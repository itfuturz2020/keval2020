import 'dart:convert';

import 'package:bss_admin/common/classList.dart';
import 'package:bss_admin/common/constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

Dio dio = new Dio();
Xml2Json xml2json = new Xml2Json();

class Services {
  static Future<List<courceClass>> getCource() async {
    String url = API_URL + 'GetCource';
    print("getCource URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<courceClass> courceClassList = [];
        print("getCource Response" + response.data.toString());

        final jsonResponse = response.data;
        courceClassData data = new courceClassData.fromJson(jsonResponse);

        courceClassList = data.Data;

        return courceClassList;
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (e) {
      print("getCource Erorr : " + e.toString());
      throw Exception(e);
    }
  }

  static Future<SaveDataClass> SaveStudent(body) async {
    print(body.toString());
    String url = API_URL + 'SaveStudent';
    print("SaveStudent : " + url);
//    dio.options.contentType = Headers.formUrlEncodedContentType;
//    dio.options.responseType = ResponseType.json;
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: '0');

//        xml2json.parse(response.data.toString());
//        var jsonData = xml2json.toParker();
//        var responseData = json.decode(jsonData);
        var responseData = response.data;

        print("SaveStudent Response: " + responseData.toString());

        saveData.Message = responseData["Message"].toString();
        saveData.IsSuccess =
            responseData["IsSuccess"] == "true" ? true : false;
        saveData.Data = responseData["Data"].toString();

        return saveData;
      } else {
        print("Server Error");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("App Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
