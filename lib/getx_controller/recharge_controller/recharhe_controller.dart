
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regent/utils/snackbar.dart';

import '../../api_utility/api_client.dart';
import '../../utils/modal/recharge_modal/circle_code_modal.dart';
import '../../utils/modal/recharge_modal/operator_list_modal.dart';
import '../../utils/modal/recharge_modal/recharge_modal.dart';
import '../../utils/modal/recharge_modal/view_all_plan_modal.dart';
import '../../utils/shred_prefrences/shared_prefrences.dart';

class RechargeController extends GetxController{
  RxList<DatumOperator> allOperatorList=List<DatumOperator>.empty(growable: true).obs;
  RxList MobileOperatorList=List.empty(growable: true).obs;
  RxString rechargeAmount="".obs;
  RxString number="".obs;
  RxString operator="".obs;
  RxString selectedCircle="".obs;
  RxString id="".obs;
  RxString spKey="".obs;
  RxList circleList =List.empty(growable: true).obs;
  RxString ciccleCode="".obs;
  RxList<Datum>  tempcircleList  =List<Datum>.empty(growable: true).obs;
  RxList<TypeType> rechargePlanRechargeList=List<TypeType>.empty(growable: true).obs;
  RxList<PDetail> rechargePlanRechargeListDetail=List<PDetail>.empty(growable: true).obs;
   RxString selectedPlan="Select Plan".obs;


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
        //Get.back();
        RechargeModal modal= response;
        ShowCustomSnackBar().SuccessSnackBar(modal.message);
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

  void viewPlan()async{
    getPlan();
    Get.bottomSheet(
      backgroundColor: Colors.white,
     Obx(()=> (rechargePlanRechargeList.value.length==null) ?
       Container(
           child: Center(
        child: CircularProgressIndicator(),
    ),
       ):Container(
       // height:800,
         child: Column(
           children: [
           Container(
             margin: EdgeInsets.symmetric(vertical: 10),
             height: 40,
             child: ListView.builder(
               shrinkWrap: true,
               scrollDirection: Axis.horizontal,
               itemCount: rechargePlanRechargeList.value.length,
               itemBuilder: (context,index){
                 return Container(
                   alignment: Alignment.center,
                   height: 20,
                   margin: EdgeInsets.symmetric(horizontal: 10),
                   padding: EdgeInsets.symmetric(horizontal: 10),
                   decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(8)
                   ),
                   child: InkWell(
                     onTap: (){
                       rechargePlanRechargeListDetail.value= rechargePlanRechargeList.value[index].pDetails;
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(rechargePlanRechargeList.value[index].pType,style: TextStyle(
                         color: Colors.white,
                         fontSize: 15
                       ),),
                     ),
                   ),
                 );
               },
             ),
           ) ,
            Container(
              height: 300,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:rechargePlanRechargeListDetail.value.length ,
                  itemBuilder: (context,index){
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: ListTile(
                        onTap: (){
                          Get.back();
                          selectedPlan.value= rechargePlanRechargeListDetail.value[index].rs.toString();
                          rechargeAmount.value=  rechargePlanRechargeListDetail.value[index].rs.toString();
                        },
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Plan : ",style: TextStyle(
                                color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                            Expanded(child: Text("${rechargePlanRechargeListDetail.value[index].desc.toString()}",
// maxLines: 10,
                              softWrap: true,)),
                          ],
                        ),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Validity :  ",style: TextStyle(
                                color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: 20
                            )),
                            Text(rechargePlanRechargeListDetail.value[index].validity.toString(),style: TextStyle(
                                color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: 20
                            )),
                          ],
                        ),
                        trailing: Text("₹ ${rechargePlanRechargeListDetail.value[index].rs.toString()}",style: TextStyle(
                            color: Colors.green  ,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    );
                  },
                ),
              ),
            )
         ]),
       ) )
    ) ;
  }


  Future<String> getPlan()async{
    var response=await APiProvider().getAllPlan();
    if(response!=null){
      VIewAllPlanModal  modal=response;
      rechargePlanRechargeList.value=modal.data.data.types;
      rechargePlanRechargeListDetail.value=rechargePlanRechargeList.value[0].pDetails;
      debugPrint(modal.toString()) ;
      debugPrint("modal.toString()") ;
    }
    debugPrint("modal.toString()") ;
    return "cdlkk";
  }

}






