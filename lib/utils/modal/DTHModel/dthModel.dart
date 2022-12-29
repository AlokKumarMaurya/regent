// To parse this JSON data, do
//
//     final dthModel = dthModelFromJson(jsonString);

import 'dart:convert';

DthModel dthModelFromJson(String str) => DthModel.fromJson(json.decode(str));

String dthModelToJson(DthModel data) => json.encode(data.toJson());

class DthModel {
  DthModel({
  required  this.message,
  required  this.data,
  required  this.status,
  });

  String message;
  DthModelData data;
  bool status;

  factory DthModel.fromJson(Map<String, dynamic> json) => DthModel(
    message: json["message"],
    data: DthModelData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "status": status,
  };
}

class DthModelData {
  DthModelData({
  required this.data,
  required this.statusCode,
  required this.errorCode,
  required this.msg,
  });

  DataData data;
  int statusCode;
  int errorCode;
  String msg;

  factory DthModelData.fromJson(Map<String, dynamic> json) => DthModelData(
    data: DataData.fromJson(json["data"]),
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

class DataData {
  DataData({
   required this.statusCode,
   required this.data,
   required this.msg,
  });

  int statusCode;
  List<DataList> data;
  String msg;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    statusCode: json["statusCode"],
    data: List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class DataList {
  DataList({
  required  this.pType,
  required  this.pDetials,
  });

  String pType;
  List<PDetial> pDetials;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    pType: json["pType"],
    pDetials: List<PDetial>.from(json["pDetials"].map((x) => PDetial.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pType": pType,
    "pDetials": List<dynamic>.from(pDetials.map((x) => x.toJson())),
  };
}

class PDetial {
  PDetial({
   required this.packageName,
    this.price,
    required this.pDescription,
    required this.packageId,
    this.pLangauge,
    required this.pCount,
    required this.pChannelCount,
  });

  String packageName;
  Price? price;
  String pDescription;
  int packageId;
  PLangauge? pLangauge;
  int pCount;
  int pChannelCount;

  factory PDetial.fromJson(Map<String, dynamic> json) => PDetial(
    packageName: json["packageName"] ?? "null",
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    pDescription: json["pDescription"] ?? "null",
    packageId: json["packageId"],
    pLangauge: pLangaugeValues.map[json["pLangauge"]],
    pCount: json["pCount"],
    pChannelCount: json["pChannelCount"],
  );

  Map<String, dynamic> toJson() => {
    "packageName": packageName == null ? null : packageName,
    "price": price == null ? null : price?.toJson(),
    "pDescription": pDescription == null ? null : pDescription,
    "packageId": packageId,
    "pLangauge": pLangaugeValues.reverse![pLangauge],
    "pCount": pCount,
    "pChannelCount": pChannelCount,
  };
}

enum PLangauge { TELUGU, OTHER, GUJARATI, HINDI, KANNADA, MALAYALAM, MARATHI, ODIA, TAMIL, BENGALI }

final pLangaugeValues = EnumValues({
  "Bengali": PLangauge.BENGALI,
  "Gujarati": PLangauge.GUJARATI,
  "Hindi": PLangauge.HINDI,
  "Kannada": PLangauge.KANNADA,
  "Malayalam": PLangauge.MALAYALAM,
  "Marathi": PLangauge.MARATHI,
  "Odia": PLangauge.ODIA,
  "Other": PLangauge.OTHER,
  "Tamil": PLangauge.TAMIL,
  "Telugu": PLangauge.TELUGU
});

class Price {
  Price({
   required this.monthly,
   required this.quarterly,
   required this.halfYearly,
   required this.yearly,
  });

  String monthly;
  String quarterly;
  String halfYearly;
  String yearly;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    monthly: json["monthly"],
    quarterly: json["quarterly"],
    halfYearly: json["halfYearly"],
    yearly: json["yearly"],
  );

  Map<String, dynamic> toJson() => {
    "monthly": monthly,
    "quarterly": quarterly,
    "halfYearly": halfYearly,
    "yearly": yearly,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>?  reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
