// To parse this JSON data, do
//
//     final rechargeModal = rechargeModalFromJson(jsonString);

import 'dart:convert';

RechargeModal rechargeModalFromJson(String str) => RechargeModal.fromJson(json.decode(str));

String rechargeModalToJson(RechargeModal data) => json.encode(data.toJson());

class RechargeModal {
  RechargeModal({
   required this.account,
   required this.amount,
   required this.rpid,
   required this.agentid,
   required this.opid,
   required this.isRefundStatusShow,
   required this.status,
   required this.msg,
   required this.bal,
   required this.errorcode,
  });

  String account;
  dynamic amount;
  String rpid;
  String agentid;
  String opid;
  bool isRefundStatusShow;
  dynamic status;
  String msg;
  dynamic bal;
  String errorcode;

  factory RechargeModal.fromJson(Map<String, dynamic> json) => RechargeModal(
    account: json["account"],
    amount: json["amount"],
    rpid: json["rpid"],
    agentid: json["agentid"],
    opid: json["opid"],
    isRefundStatusShow: json["isRefundStatusShow"],
    status: json["status"],
    msg: json["msg"],
    bal: json["bal"].toDouble(),
    errorcode: json["errorcode"],
  );

  Map<String, dynamic> toJson() => {
    "account": account,
    "amount": amount,
    "rpid": rpid,
    "agentid": agentid,
    "opid": opid,
    "isRefundStatusShow": isRefundStatusShow,
    "status": status,
    "msg": msg,
    "bal": bal,
    "errorcode": errorcode,
  };
}