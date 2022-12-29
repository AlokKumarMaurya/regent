import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regent/utils/shred_prefrences/shared_prefrences.dart';

import '../../api_utility/api_client.dart';
import '../../utils/modal/all_dash_board_modals/all_recharge_type.dart';
import '../../utils/modal/drawer_modal/check_balance.dart';
import '../../utils/modal/transaction History Model/transaction_history_model.dart';

class AllRechargeTypeController extends GetxController{

  RxList<AllRecharegeType> allRechargeList=List<AllRecharegeType>.empty(growable: true).obs;
   RxString balance="".obs;

  @override
  void onInit() {
    getAllRechargeType();
    getBalance();
    transactionHistory();

    // TODO: implement onInit
    super.onInit();
  }

  getAllRechargeType()async{
    var response =await APiProvider().getAllRechargetype();
    if(response!=null){
      allRechargeList.value=response;
  debugPrint(allRechargeList.value.length.toString()) ;
  debugPrint("allRechargeList.value.length.toString()") ;
  debugPrint(allRechargeList.value[0].toString()) ;
  getBalance();
      transactionHistory();
    }
  }
  getBalance()async{
    debugPrint("0000000000000000000000000");
    var id=await SharedPrefrences().getIdofUser();
    debugPrint(id.toString());
    debugPrint("id.toString()");
    var response=await APiProvider().getUserBalance(id);
    if(response!=null){
      CheckBalance modal=response;
      balance.value=modal.data[0].balance.toString();
      debugPrint(balance.value.toString());
    }
  }

  transactionHistory()async{
    debugPrint("0000000000000000000000000");
    var id=await SharedPrefrences().getIdofUser();
    debugPrint(id.toString());
    debugPrint("id.toString()");
    var response=await APiProvider().transactionHistory();
    if(response!=null){
    TransactionHistory modal=response;
    //  balance.value=modal.data[0].balance.toString();
      debugPrint(balance.value.toString());
    }
  }
}