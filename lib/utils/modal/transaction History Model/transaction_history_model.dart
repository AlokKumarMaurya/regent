// To parse this JSON data, do
//
//     final transactionHistory = transactionHistoryFromJson(jsonString);

import 'dart:convert';

TransactionHistory transactionHistoryFromJson(String str) => TransactionHistory.fromJson(json.decode(str));

String transactionHistoryToJson(TransactionHistory data) => json.encode(data.toJson());

class TransactionHistory {
  TransactionHistory({
  required  this.message,
  required  this.data,
  required  this.status,
  });

  String message;
  List<HistoryList> data;
  bool status;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
    message: json["message"],
    data: List<HistoryList>.from(json["data"].map((x) => HistoryList.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class HistoryList {
  HistoryList({
  required this.id,
  required this.userId,
  required this.transactionId,
  required this.accountNo,
  required this.HistoryListOperator,
  required this.amount,
  required this.status,
  required this.createdAt,
    this.updatedAt,
  });

  String id;
  String userId;
  String transactionId;
  String accountNo;
  String HistoryListOperator;
  String amount;
  String status;
  DateTime createdAt;
  dynamic updatedAt;

  factory HistoryList.fromJson(Map<String, dynamic> json) => HistoryList(
    id: json["id"],
    userId: json["user_id"],
    transactionId: json["transaction_id"],
    accountNo: json["account_no"],
    HistoryListOperator: json["operator"],
    amount: json["amount"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "transaction_id": transactionId,
    "account_no": accountNo,
    "operator": HistoryListOperator,
    "amount": amount,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
