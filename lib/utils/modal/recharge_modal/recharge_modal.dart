// To parse this JSON data, do
//
//     final rechargeModal = rechargeModalFromJson(jsonString);

import 'dart:convert';

RechargeModal rechargeModalFromJson(String str) => RechargeModal.fromJson(json.decode(str));

String rechargeModalToJson(RechargeModal data) => json.encode(data.toJson());

class RechargeModal {
  RechargeModal({
  required  this.message,
  });

  String message;

  factory RechargeModal.fromJson(Map<String, dynamic> json) => RechargeModal(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
