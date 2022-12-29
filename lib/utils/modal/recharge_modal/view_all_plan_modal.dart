// To parse this JSON data, do
//
//     final vIewAllPlanModal = vIewAllPlanModalFromJson(jsonString);

import 'dart:convert';

VIewAllPlanModal vIewAllPlanModalFromJson(String str) => VIewAllPlanModal.fromJson(json.decode(str));

String vIewAllPlanModalToJson(VIewAllPlanModal data) => json.encode(data.toJson());

class VIewAllPlanModal {
  VIewAllPlanModal({
  required  this.message,
  required  this.data,
  required  this.status,
  });

  String message;
  VIewAllPlanModalData data;
  bool status;

  factory VIewAllPlanModal.fromJson(Map<String, dynamic> json) => VIewAllPlanModal(
    message: json["message"],
    data: VIewAllPlanModalData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "status": status,
  };
}

class VIewAllPlanModalData {
  VIewAllPlanModalData({
   required this.data,
   required this.statusCode,
   required this.errorCode,
   required this.msg,
  });

  PurpleData data;
  int statusCode;
  int errorCode;
  String msg;

  factory VIewAllPlanModalData.fromJson(Map<String, dynamic> json) => VIewAllPlanModalData(
    data: PurpleData.fromJson(json["data"]),
    statusCode: json["statusCode"],
    errorCode: json["errorCode"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "statusCode": statusCode,
    "errorCode": errorCode,
    "msg": msg,
  };
}

class PurpleData {
  PurpleData({
   required this.statusCode,
   required this.data,
   required this.msg,
  });

  int statusCode;
  FluffyData data;
  String msg;

  factory PurpleData.fromJson(Map<String, dynamic> json) => PurpleData(
    statusCode: json["statusCode"],
    data: FluffyData.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data.toJson(),
    "msg": msg,
  };
}

class FluffyData {
  FluffyData({
    required this.types,
  });

  List<TypeType> types;

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
    types: List<TypeType>.from(json["types"].map((x) => TypeType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
  };
}

class TypeType {
  TypeType({
  required this.pType,
  required this.pDetails,
  });

  String pType;
  List<PDetail> pDetails;

  factory TypeType.fromJson(Map<String, dynamic> json) => TypeType(
    pType: json["pType"],
    pDetails: List<PDetail>.from(json["pDetails"].map((x) => PDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pType": pType,
    "pDetails": List<dynamic>.from(pDetails.map((x) => x.toJson())),
  };
}

class PDetail {
  PDetail({
   required this.rs,
   required this.desc,
   required this.validity,
  });

  String rs;
  String desc;
  String validity;

  factory PDetail.fromJson(Map<String, dynamic> json) => PDetail(
    rs: json["rs"],
    desc: json["desc"],
    validity: json["validity"],
  );

  Map<String, dynamic> toJson() => {
    "rs": rs,
    "desc": desc,
    "validity": validity,
  };
}
