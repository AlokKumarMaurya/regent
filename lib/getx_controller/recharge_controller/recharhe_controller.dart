
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regent/utils/snackbar.dart';

import '../../api_utility/api_client.dart';
import '../../utils/modal/recharge_modal/circle_code_modal.dart';
import '../../utils/modal/recharge_modal/operator_list_modal.dart';
import '../../utils/modal/recharge_modal/recharge_modal.dart';
import '../../utils/shred_prefrences/shared_prefrences.dart';

class RechargeController extends GetxController{
  RxList<DatumOperator> allOperatorList=List<DatumOperator>.empty(growable: true).obs;
  RxList MobileOperatorList=List.empty(growable: true).obs;
  RxString rechargeAmount="".obs;
  RxString number="".obs;
  RxString operator="".obs;
  RxString selectedCircle="".obs;
  RxString id="".obs;
  RxList     circleList  =List.empty(growable: true).obs;
  RxList<Datum>     tempcircleList  =List<Datum>.empty(growable: true).obs;
  getAllOperatorList()async{
    var response =await APiProvider().getAllServiceOperator();
    if(response!=null){
      AllOperatorListModal modal=response;
      allOperatorList=modal.data.obs;
      MobileOperatorList.add("Select Operator");


      allOperatorList.where((p)  {
        if(p.serviceName=="Recharge Plan"){
          MobileOperatorList.value.add(p.operatorName);
        }
        return true;
      }).toList();

      debugPrint(MobileOperatorList.value.toString());
    }
  }
  getId()async{
    id.value=await SharedPrefrences().getIdofUser();
  }
  @override
  void onInit() {
    getId();
    getAllOperatorList();
    getCircleCode();
    // TODO: implement onInit
    super.onInit();
  }

  void doRecharge()async{
    if(operator.value==""){
      ShowCustomSnackBar().ErrorSnackBar("Select operator first");
    }else if(rechargeAmount.value==""){
      ShowCustomSnackBar().ErrorSnackBar("Enter amount");
    }  else if(number.value=="" || number.value.length<10){
      ShowCustomSnackBar().ErrorSnackBar("Enter a valid number");
    }  else{
      Get.dialog(Center(child: CircularProgressIndicator(),)) ;
      var response=await APiProvider().makeRecharge() ;
      if(response!=null){
        Get.back();
        Get.back();
        RechargeModal modal= response;
        ShowCustomSnackBar().SuccessSnackBar(modal.msg);
      }
    }

  }

  bool filterOperatorList(String type){
    MobileOperatorList.value.clear();
    allOperatorList.where((p)  {
      if(p.serviceName==type){
        MobileOperatorList.value.add(p.operatorName);
      }
      return true;
    }).toList();
    if(MobileOperatorList.value.length>1){
      return true;
    }  else return false;
  }

  void getCircleCode()async{
    var response=await APiProvider().getAllCircleList();
    debugPrint("34343534453454545343543543543543");
    if(response!=null){
      debugPrint("34343534453454545343543543543543");
      CircleCodeModal modal=response;
      debugPrint(modal.data.toString());
      debugPrint(modal.data[0].circleName.toString());

        tempcircleList=modal.data.obs;
        
      tempcircleList.where((element) {
        debugPrint(element.circleName.toString());
        debugPrint("element.circleName.toString()");
         circleList.add(element.circleName);
         return false;
      }).toList();
      debugPrint(circleList.value.toString());
      debugPrint("circleList.value.toString()");
    }
  }

}