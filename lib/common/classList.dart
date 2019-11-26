import 'dart:convert';

class SaveDataClass {
  String Message;
  bool IsSuccess;
  bool IsRecord;
  String Data;

  SaveDataClass({this.Message, this.IsSuccess, this.IsRecord, this.Data});

  factory SaveDataClass.fromJson(Map<String, dynamic> json) {
    return SaveDataClass(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        IsRecord: json['IsRecord'] as bool,
        Data: json['Data'] as String);
  }
}

class courceClassData {
  String Message;
  bool IsSuccess;
  List<courceClass> Data;

  courceClassData({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory courceClassData.fromJson(Map<String, dynamic> json) {
    return courceClassData(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<courceClass>((json) => courceClass.fromJson(json))
            .toList());
  }
}

class courceClass {
  String id;
  String name;

  courceClass({this.id, this.name});

  factory courceClass.fromJson(Map<String, dynamic> json) {
    return courceClass(
        id: json['Id'].toString() as String,
        name: json['Name'].toString() as String);
  }
}

class batchClassData {
  String Message;
  bool IsSuccess;
  List<batchClass> Data;

  batchClassData({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory batchClassData.fromJson(Map<String, dynamic> json) {
    return batchClassData(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<batchClass>((json) => batchClass.fromJson(json))
            .toList());
  }
}

class batchClass {
  String id;
  String name;
  String fromDate;
  String toDate;

  batchClass({this.id, this.name, this.fromDate, this.toDate});

  factory batchClass.fromJson(Map<String, dynamic> json) {
    return batchClass(
        id: json['Id'].toString() as String,
        name: json['Title'].toString() as String,
        fromDate: json['FromTime'].toString() as String,
        toDate: json['ToTime'].toString() as String);
  }
}
