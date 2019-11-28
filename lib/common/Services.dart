import 'dart:convert';

import 'package:bss_admin/common/classList.dart';
import 'package:bss_admin/common/constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

Dio dio = new Dio();
Xml2Json xml2json = new Xml2Json();

class Services {
  static Future<List> Login(String userName, String password) async {
    String url = API_URL + 'StaffLogin?usename=$userName&password=$password';
    print("Login URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Login Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          print(responseData["Data"]);
          list = responseData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (e) {
      print("Login Erorr : " + e.toString());
      throw Exception(e);
    }
  }

  static Future<List> GetStudent(String courceId, String batchId) async {
    String url =
        API_URL + 'GetStudentByCourceBatch?CourceId=$courceId&BatchId=$batchId';
    print("GetStudent URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("GetStudent Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          print(responseData["Data"]);
          list = responseData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (e) {
      print("GetStudent Erorr : " + e.toString());
      throw Exception(e);
    }
  }

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

  static Future<List<batchClass>> getBatch() async {
    String url = API_URL + 'GetBatch';
    print("GetBatch URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<batchClass> batchClassList = [];
        print("GetBatch Response" + response.data.toString());

        final jsonResponse = response.data;
        batchClassData data = new batchClassData.fromJson(jsonResponse);

        batchClassList = data.Data;

        return batchClassList;
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (e) {
      print("GetBatch Erorr : " + e.toString());
      throw Exception(e);
    }
  }

  static Future<SaveDataClass> SaveStudent(body) async {
    print(body.toString());
    String url = API_URL + 'SaveStudent';
    print("SaveStudent : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: '0');
        var responseData = response.data;

        print("SaveStudent Response: " + responseData.toString());

        saveData.Message = responseData["Message"].toString();
        saveData.IsSuccess =
            responseData["IsSuccess"].toString() == "true" ? true : false;
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

  static Future<List> GetAllPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Id = prefs.getString(Session.Id);
    String url = API_URL + 'GetOtherStudentPhoto?studentId=$Id';
    print("GetAllPhotos URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("GetAllPhotos Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true) {
          list = responseData["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception("Something Went Wrong");
      }
    } catch (e) {
      print("GetAllPhotosById Erorr : " + e.toString());
      throw Exception(e);
    }
  }

  static Future<SaveDataClass> SaveStudentByScan(String studentID) async {
    String url = API_URL + 'SaveAttendance?StudentId=$studentID';
    print("SaveStudentByScan : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: '0');
        var responseData = response.data;
        print("SaveStudentByScan Response: " + responseData.toString());
        saveData.Message = responseData["Message"].toString();
        saveData.IsSuccess =
            responseData["IsSuccess"].toString() == "true" ? true : false;
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
