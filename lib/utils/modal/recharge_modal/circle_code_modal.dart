// To parse this JSON data, do
//
//     final circleCodeModal = circleCodeModalFromJson(jsonString);

import 'dart:convert';

CircleCodeModal circleCodeModalFromJson(String str) => CircleCodeModal.fromJson(json.decode(str));

String circleCodeModalToJson(CircleCodeModal data) => json.encode(data.toJson());

class CircleCodeModal {
  CircleCodeModal({
   required this.data,
   required this.statusCode,
   required this.errorCode,
   required this.msg,
  });

  List<Datum> data;
  int statusCode;
  int errorCode;
  String msg;

  factory CircleCodeModal.fromJson(Map<String, dynamic> json) => CircleCodeModal(
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
   required this.circleCode,
   required this.circleName,
  });

  int circleCode;
  String circleName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    circleCode: json["circleCode"],
    circleName: json["circleName"],
  );

  Map<String, dynamic> toJson() => {
    "circleCode": circleCode,
    "circleName": circleName,
  };
}
