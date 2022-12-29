import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api_utility/api_client.dart';
import '../../../utils/modal/transaction History Model/transaction_history_model.dart';
import '../../../utils/shred_prefrences/shared_prefrences.dart';

class TransactionReport extends GetxController{

  RxList<HistoryList> historyList=List<HistoryList>.empty(growable: true).obs;

   @override
  onInit(){
     transactionHistory();
     super.onInit();
   }
  transactionHistory()async{
    debugPrint("0000000000000000000000000======>>>>>>");
    var id=await SharedPrefrences().getIdofUser();
    debugPrint(id.toString());  Get.dialog(Center(child: CircularProgressIndicator()));
    debugPrint("id.toString()");
    var response=await APiProvider().transactionHistory();
    debugPrint("responsiiiiiii"+response.toString());

    if(response!=null){
      TransactionHistory modal=response;
      historyList.value=modal.data;
      debugPrint(historyList.value.toString());
      Get.back();
    }    else{
      Get.back();
    }

  }


}