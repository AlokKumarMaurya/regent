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

  List<DatumOperator> data;
  int statusCode;
  int errorCode;
  String msg;

  factory AllOperatorListModal.fromJson(Map<String, dynamic> json) => AllOperatorListModal(
    data: List<DatumOperator>.from(json["data"].map((x) => DatumOperator.fromJson(x))),
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

class DatumOperator {
  DatumOperator({
   required this.serviceName,
   required this.operatorName,
   required this.spKey,
  });

  String serviceName;
  String operatorName;
  String spKey;

  factory DatumOperator.fromJson(Map<String, dynamic> json) => DatumOperator(
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
