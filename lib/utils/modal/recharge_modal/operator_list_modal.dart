// To parse this JSON data, do
//
//     final allOperatorListModal = allOperatorListModalFromJson(jsonString);

import 'dart:convert';

AllOperatorListModal allOperatorListModalFromJson(String str) => AllOperatorListModal.fromJson(json.decode(str));

String allOperatorListModalToJson(AllOperatorListModal data) => json.encode(data.toJson());

class AllOperatorListModal {
  AllOperatorListModal({
   required this.data,
   required this.statusCode,
   required this.errorCode,
   required this.msg,
  });

  List<Datum> data;
  int statusCode;
  int errorCode;
  String msg;

  factory AllOperatorListModal.fromJson(Map<String, dynamic> json) => AllOperatorListModal(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    statusCode: json["statusCode"],
    errorCode: json["errorCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "statusCode": statusCode,
    "errorCode": errorCode,
    "msg": msg,
  };
}

class Datum {
  Datum({
   required this.serviceName,
   required this.operatorName,
   required this.spKey,
  });

  String serviceName;
  String operatorName;
  String spKey;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    serviceName: json["serviceName"],
    operatorName: json["operatorName"],
    spKey: json["spKey"],
  );

  Map<String, dynamic> toJson() => {
    "serviceName": serviceName,
    "operatorName": operatorName,
    "spKey": spKey,
  };
}
