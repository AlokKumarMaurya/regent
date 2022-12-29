import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;
import 'package:regent/api_utility/constUrl.dart';
import 'package:regent/getx_controller/login_controller/login_controller.dart';
import 'package:regent/utils/shred_prefrences/shared_prefrences.dart';

import '../getx_controller/dash_board_controller/all_recharege_type_controller.dart';
import '../getx_controller/recharge_controller/recharhe_controller.dart';
import '../utils/modal/DTHModel/dthModel.dart';
import '../utils/modal/all_dash_board_modals/all_recharge_type.dart';
import '../utils/modal/drawer_modal/check_balance.dart';
import '../utils/modal/login_modal.dart';
import '../utils/modal/recharge_modal/circle_code_modal.dart';
import '../utils/modal/recharge_modal/operator_list_modal.dart';
import '../utils/modal/recharge_modal/recharge_modal.dart';
import '../utils/modal/recharge_modal/view_all_plan_modal.dart';
import '../utils/modal/transaction History Model/transaction_history_model.dart';
import '../utils/snackbar.dart';

class APiProvider extends GetConnect {
  var token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE1ODk1IiwidG9rZW4iOiJmMDVjZTRjZTYxMDQ2MTA3Mjg3ODdkZGM4ZTNmNTBlNiIsIm5iZiI6MTY3MTYyMDM1MCwiZXhwIjoxNjcyNDg0MzUwLCJpYXQiOjE2NzE2MjAzNTB9.tcDVIdvGMyjX8Y4h6ezh46_PJHctFX66B6ALbLobgPg";

  login() async {
    LoginController _loginController = Get.put(LoginController());
    debugPrint(
        "${_loginController.userId.value.text}   ${_loginController.password.value.text} ");
    try {
      var body = {
        "Id": _loginController.userId.value.text,
        "Password": _loginController.password.value.text
      };
      var response = await post(
        RegentUrl.login,
        jsonEncode(body),
      );
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response.body["message"].toString() == "Data not found") {
          Get.back();
          ShowCustomSnackBar()
              .ErrorSnackBar(response.body["message"].toString());
        } else {
          LoginModal modal = LoginModal.fromJson((response.body));
          return modal;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      // ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  getAllServiceOperator() async {
    try {
      var response = await get(RegentUrl.getAllOperator, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      if (response != null) {
        debugPrint(response.toString());
        AllOperatorListModal modal =
            AllOperatorListModal.fromJson((response.body));
        return modal;
      }
    } catch (e) {
      // ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  makeRecharge() async {
    AllRechargeTypeController _all = Get.put(AllRechargeTypeController());
    String UserId = await SharedPrefrences().getIdofUser();
    RechargeController _rechargeController = Get.put(RechargeController());
    var titleName = SharedPrefrences().getTitleName();
    var spky;
    if (titleName == "Prepaid ") {
      if (_rechargeController.operator.value == "Airtel") {
        spky = 3;
      } else if (_rechargeController.operator.value == "Bsnl") {
        spky = 4;
      } else if (_rechargeController.operator.value == "Vodafone") {
        spky = 37;
      } else if (_rechargeController.operator.value == "Reliance Jio") {
        spky = 116;
      } else if (_rechargeController.operator.value == "Idea") {
        spky = 12;
      }
    } else if (titleName == "DTH") {
      if (_rechargeController.operator.value == "Airtel Digital TV") {
        spky = 51;
      } else if (_rechargeController.operator.value == "Dish TV") {
        spky = 53;
      } else if (_rechargeController.operator.value == "Sun Direct") {
        spky = 54;
      } else if (_rechargeController.operator.value == "Tata Sky") {
        spky = 55;
      } else if (_rechargeController.operator.value == "Videocon D2h") {
        spky = 56;
      }
    } else {
      ShowCustomSnackBar().ErrorSnackBar("Spkey issue");
    }


    var rand = DateTime.now();
    /*var body={
      "UserID":15895,
      "Token":"f05ce4ce6104610728787ddc8e3f50e6",
      "Account":  _rechargeController.number.value,
      "Amount":_rechargeController.rechargeAmount.value ,
      "SPKey":spky ,
      "APIRequestID":"1170026",
      "GEOCode":"27.2046%C2%B0%20N,%2077.4977%C2%B0",
      "CustomerNumber": 9753404112 ,
      "Pincode":226010 ,
      "Format":1  ,
      "OutletID":18449   ,
      "RefID": ""   ,
      "fetchBillID":   ""
    } ;*/
    var body = {
      "SPKey": spky.toString(),
      "GEOCode": "27.2046° N, 77.4977°",
      "Pincode": "226010",
      "Amount": _rechargeController.rechargeAmount.toString(),
      "Account": _rechargeController.number.value.toString(),
      "user_id": UserId,
    };

    print("asdads" + body.toString());
    try {
      var response = await http.post(Uri.parse(RegentUrl.recharge), body: body);
      debugPrint("asdads" + response.body.toString());
      debugPrint(response.statusCode.toString());
      _rechargeController.rechargeAmount.value="";
      _rechargeController.selectedPlan.value="";
      _rechargeController.rechargeAmount.value="";
      _rechargeController.number.value="";
      if (response.statusCode == 200) {
        RechargeModal modal = rechargeModalFromJson(response.body);

        _all.getBalance();
        //  Get.back();
        return modal;
      }
    } catch (e) {
      _rechargeController.rechargeAmount.value="";
      _rechargeController.selectedPlan.value="";
      _rechargeController.rechargeAmount.value="";
      _rechargeController.number.value="";
      Get.back();
      print(e.toString());
      // ShowCustomSnackBar().ErrorSnackBar("Recharge succefull");
    }
    _rechargeController.number.value="";
    _rechargeController.rechargeAmount.value="";
    _rechargeController.selectedPlan.value="";
    _rechargeController.rechargeAmount.value="";
       debugPrint(_rechargeController.number.value);
       debugPrint("_rechargeController.number.value");
    // _rechargeController.="";

  }

  getAllRechargetype() async {
    try {
      var body = {"type": "category"};
      var response = await post(RegentUrl.getAllRechargeType, body);
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        List<AllRecharegeType> modal = List<AllRecharegeType>.from(
            (response.body).map((x) => AllRecharegeType.fromJson(x)));
        debugPrint(modal.toString());
        return modal;
      }
    } catch (e) {
      debugPrint(e.toString());
      // ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }


transactionHistory() async {
  String UserId = await SharedPrefrences().getIdofUser();
    try {
      var body = {"id": UserId};
      var response = await post(RegentUrl.transactionHistory, body);
      debugPrint("Transaction History Response==>>${response.body}");
      if (response.statusCode == 200) {

        TransactionHistory modal =
        TransactionHistory.fromJson((response.body));
        return modal;

      }
    } catch (e) {
      debugPrint(e.toString());
      // ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  getUserBalance(String userId) async {
    var body = {"id": userId};
    try {
      debugPrint("get user balance");
      var response = await http.post(Uri.parse(RegentUrl.getBalance),body: body);
      if (response.statusCode == 200) {
        debugPrint("get user balance"+response.body);
        CheckBalance modal = CheckBalance.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {
      // ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  getAllCircleList() async {
    try {
      var response =
          await http.get(Uri.parse(RegentUrl.getCircleCode), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      });

      print("response.statusCode" + response.body.toString());
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        CircleCodeModal modal = CircleCodeModal.fromJson(res);
        debugPrint("1111111111111111111111111111");
        debugPrint(modal.data.length.toString());
        debugPrint(modal.data[0].circleName.toString());
        return modal;
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("e.toString()");
      // ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }

  getAllPlan() async {
    RechargeController _rechargeController = Get.put(RechargeController());
    var titleName = SharedPrefrences().getTitleName();
    var Url = "";
    print("titleName" + titleName + "asdads");

    if (titleName == "Prepaid ") {
      Url = RegentUrl.rechargePlan;
    } else if (titleName == "DTH") {
      Url = RegentUrl.dthRechargePlan;
    } else {
      ShowCustomSnackBar().ErrorSnackBar("Title Name is Not Correct");
    }

    try {
      debugPrint(
          "viePlan Response==>" + _rechargeController.spKey.value.toString());
      debugPrint("viePlan Response==>" +
          _rechargeController.ciccleCode.value.toString());
      Map body = {
        "spkey": _rechargeController.spKey.value,
        "circleId": _rechargeController.ciccleCode.value
      };

      var response =
          await http.post(Uri.parse(Url), body: body);
      debugPrint("viePlan Response==>" + response.body.toString());
      debugPrint("viePlan Response==>" + response.statusCode.toString());

      if (response.statusCode == 200) {
        if (titleName == "Prepaid ") {
          VIewAllPlanModal modal =
              VIewAllPlanModal.fromJson(jsonDecode(response.body));

          return modal;
        } else if (titleName == "DTH") {
          ShowCustomSnackBar().ErrorSnackBar("In data Model ");
          DthModel model = DthModel.fromJson(jsonDecode(response.body));
          
          return model;
        } else {
          ShowCustomSnackBar().ErrorSnackBar("Model is Not Correct");
        }
      }
    //  Get.back();
    } catch (e) {
      // Get.back();
      print(e.toString());
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }
}
