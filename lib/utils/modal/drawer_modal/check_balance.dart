// To parse this JSON data, do
//
//     final checkBalance = checkBalanceFromJson(jsonString);

import 'dart:convert';

CheckBalance checkBalanceFromJson(String str) => CheckBalance.fromJson(json.decode(str));

String checkBalanceToJson(CheckBalance data) => json.encode(data.toJson());

class CheckBalance {
  CheckBalance({
  required this.success,
  required this.message,
  required this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory CheckBalance.fromJson(Map<String, dynamic> json) => CheckBalance(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
   required this.id,
   required this.balance,
  });

  String id;
  dynamic balance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "balance": balance,
  };
}
