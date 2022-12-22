import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:regent/api_utility/constUrl.dart';
import 'package:regent/getx_controller/login_controller/login_controller.dart';

import '../getx_controller/recharge_controller/recharhe_controller.dart';
import '../utils/modal/login_modal.dart';
import '../utils/modal/recharge_modal/operator_list_modal.dart';
import '../utils/modal/recharge_modal/recharge_modal.dart';
import '../utils/snackbar.dart';

class APiProvider extends GetConnect {

  login() async {
    LoginController _loginController = Get.put(LoginController());
    debugPrint("${_loginController.userId.value.text}   ${ _loginController.password.value.text} ") ;
    try {
      var body = {
        "Id": _loginController.userId.value.text,
        "Password": _loginController.password.value.text
      };
      var response = await post(RegentUrl.login, jsonEncode(body),);
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        if(response.body["message"].toString()=="Data not found") {
          Get.back();
          ShowCustomSnackBar().ErrorSnackBar(response.body["message"].toString());
        } else{
          LoginModal modal=LoginModal.fromJson((response.body));
          return modal;
        }

      }
    } catch (e) {
      debugPrint(e.toString());
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
  }
  
  
  getAllServiceOperator()async{
    try{
      var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE1ODk1IiwidG9rZW4iOiJmMDVjZTRjZTYxMDQ2MTA3Mjg3ODdkZGM4ZTNmNTBlNiIsIm5iZiI6MTY3MTYyMDM1MCwiZXhwIjoxNjcyNDg0MzUwLCJpYXQiOjE2NzE2MjAzNTB9.tcDVIdvGMyjX8Y4h6ezh46_PJHctFX66B6ALbLobgPg" ;
           var response=await get(RegentUrl.getAllOperator,headers: {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': token,
           });
           if(response!=null){
             debugPrint(response.toString());
             AllOperatorListModal modal=  AllOperatorListModal.fromJson((response.body));
             return modal;
           }
    } catch(e) {
      ShowCustomSnackBar().ErrorSnackBar(e.toString());
    }
    }

  makeRecharge()async{
    RechargeController _rechargeController=Get.put(RechargeController());
    var spky;

    if(_rechargeController.operator.value=="Airtel"){
    spky=3;
    }else if(_rechargeController.operator.value=="Bsnl"){
    spky=4;
    } else if(_rechargeController.operator.value=="Vodafone"){
    spky=37;
    } else if(_rechargeController.operator.value=="Reliance Jio"){
    spky=116;
    }else if(_rechargeController.operator.value=="Idea") {
    spky=12;
    }
    var rand=DateTime.now();
    var body={
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
    } ;


    var test="https://roundpay.net/API/TransactionAPI?UserID=15895&Token=f05ce4ce6104610728787ddc8e3f50e6&Account=${_rechargeController.number.value}&Amount=${_rechargeController.rechargeAmount.value }&SPKey=$spky&APIRequestID=$rand&GEOCode=27.2046%C2%B0%20N,%2077.4977%C2%B0&CustomerNumber=7054988484&Pincode=226010&Format=1&OutletID=18449&RefID=&fetchBillID=" ;



    try{
         var response=await get(test);
         if(response!=null){
           RechargeModal modal= RechargeModal.fromJson(response.body);
           return modal;
         }
    }catch(e){
      Get.back();
      ShowCustomSnackBar().ErrorSnackBar("Recharge succefull");
    }
  }
  }





