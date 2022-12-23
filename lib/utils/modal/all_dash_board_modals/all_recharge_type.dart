// To parse this JSON data, do
//
//     final allRecharegeType = allRecharegeTypeFromJson(jsonString);

import 'dart:convert';

List<AllRecharegeType> allRecharegeTypeFromJson(String str) => List<AllRecharegeType>.from(json.decode(str).map((x) => AllRecharegeType.fromJson(x)));

String allRecharegeTypeToJson(List<AllRecharegeType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllRecharegeType {
  AllRecharegeType({
   required this.the1,
   required this.name,
   required this.status,
   required this.data,
   required this.the2,
   required this.the3,
   required this.the4,
  });

  String? the1;
  String? name;
  String? status;
  List<Datum> data;
  String? the2;
  String? the3;
  String? the4;

  factory AllRecharegeType.fromJson(Map<String, dynamic> json) => AllRecharegeType(
    the1: json["1"] == null ? null : json["1"],
    name: json["name"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    the2: json["2"] == null ? null : json["2"],
    the3: json["3"] == null ? null : json["3"],
    the4: json["4"] == null ? null : json["4"],
  );

  Map<String, dynamic> toJson() => {
    "1": the1 == null ? null : the1,
    "name": name,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "2": the2 == null ? null : the2,
    "3": the3 == null ? null : the3,
    "4": the4 == null ? null : the4,
  };
}

class Datum {
  Datum({
   required this.operatorId,
   required this.name,
   required this.image,
   required this.status,
   required this.commingStatus,
   required this.createdAt,
   required this.oid,
   required this.opid,
   required this.nature,
   required this.op_name,
  });

  String? operatorId;
  String? name;
  String? image;
  String? status;
  String? commingStatus;
  DateTime createdAt;
  String? oid;
  String? opid;
  String? nature;
  String? op_name;
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    operatorId: json["operator_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    commingStatus: json["comming_status"],
    createdAt: DateTime.parse(json["created_at"]),
    oid: json["oid"] == null ? null : json["oid"],
    opid: json["opid"] == null ? null : json["opid"],
    nature: json["nature"],
    op_name:json["op_name"]
  );

  Map<String, dynamic> toJson() => {
    "operator_id": operatorId,
    "name": name,
    "image": image,
    "status": status,
    "comming_status": commingStatus,
    "created_at": createdAt.toIso8601String(),
    "oid": oid == null ? null : oid,
    "opid": opid == null ? null : opid,
    "nature": nature,
    "op_name":op_name
  };
}
