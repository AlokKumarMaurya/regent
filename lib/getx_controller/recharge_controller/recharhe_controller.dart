import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regent/utils/modal/DTHModel/dthModel.dart';
import 'package:regent/utils/snackbar.dart';

import '../../api_utility/api_client.dart';
import '../../utils/modal/recharge_modal/circle_code_modal.dart';
import '../../utils/modal/recharge_modal/operator_list_modal.dart';
import '../../utils/modal/recharge_modal/recharge_modal.dart';
import '../../utils/modal/recharge_modal/view_all_plan_modal.dart';
import '../../utils/shred_prefrences/shared_prefrences.dart';

class RechargeController extends GetxController {
  RxList<DatumOperator> allOperatorList =
      List<DatumOperator>.empty(growable: true).obs;
  RxList MobileOperatorList = List.empty(growable: true).obs;
  RxList SpKeyOperaterList = List.empty(growable: true).obs;
  RxString rechargeAmount = "".obs;
  RxString number = "".obs;
  RxString operator = "".obs;
  RxString selectedCircle = "".obs;
  RxString id = "".obs;
  RxString spKey = "".obs;
  RxList circleList = List.empty(growable: true).obs;
  RxString ciccleCode = "".obs;
  RxList<Datum> tempcircleList = List<Datum>.empty(growable: true).obs;
  RxList<TypeType> rechargePlanRechargeList =
      List<TypeType>.empty(growable: true).obs;
  RxList<DataList> dthPlanRechargeList =
      List<DataList>.empty(growable: true).obs;
  RxList<PDetial> dthRechargeListDetail =
      List<PDetial>.empty(growable: true).obs;
  RxList<PDetail> rechargePlanRechargeListDetail =
      List<PDetail>.empty(growable: true).obs;
  RxString selectedPlan = "Select Plan".obs;

  getAllOperatorList() async {
    debugPrint("00000000000000000000000000000000000");
    var response = await APiProvider().getAllServiceOperator();
    if (response != null) {
      AllOperatorListModal modal = response;
      allOperatorList = modal.data.obs;

      allOperatorList.where((p) {
        if (p.serviceName == "Recharge Plan") {
          MobileOperatorList.value.add(p.operatorName);
          operator.value = MobileOperatorList.value[0];
          /*       SpKeyOperaterList.value.add(p.spKey);*/
        }
        return true;
      }).toList();

      debugPrint(MobileOperatorList.value.toString());
      debugPrint("MobileOperatorList.value.toString(");
    }
  }

  getId() async {
    id.value = await SharedPrefrences().getIdofUser();
  }

  @override
  void onInit() {
    getId();
    getAllOperatorList();
    getCircleCode();
    // TODO: implement onInit
    super.onInit();
  }

  void doRecharge() async {
    debugPrint(spKey.value.toString());
    debugPrint(
        "spKey.value.toString()spKey.value.toString()spKey.value.toString()");
    if (operator.value == "") {
      ShowCustomSnackBar().ErrorSnackBar("Select operator first");
    } else if (rechargeAmount.value == "") {
      ShowCustomSnackBar().ErrorSnackBar("Enter amount");
    } else if (number.value == "" /*|| number.value.length < 10*/) {
      ShowCustomSnackBar().ErrorSnackBar("Enter a valid number");
    } else {
      Get.dialog(Center(
        child: CircularProgressIndicator(),
      ));
      debugPrint("0000000000000000000000");
      debugPrint(number.value);
      var response = await APiProvider().makeRecharge();
      if (response != null) {
        Get.back();
        number.value="";
        debugPrint("0000000000000000000000");
        debugPrint(number.value);
        //Get.back();
        RechargeModal modal = response;
        ShowCustomSnackBar().SuccessSnackBar(modal.message);
      }
    }
  }

  bool filterOperatorList(String type) {
    // debugPrint(allOperatorList.value[0].serviceName);
    for(int i=0;i<allOperatorList.value.length;i++){
      debugPrint(allOperatorList.value[i].serviceName.toString());
    }
    // debugPrint("test${type}test");
    // debugPrint("typetypetypetypetypetype");
    MobileOperatorList.value.clear();
    SpKeyOperaterList.value.clear();
    var a=allOperatorList.value.forEach((element) {debugPrint(element.serviceName.toString());});

    // debugPrint(a);
    var temp=allOperatorList.where((p) {
      debugPrint(p.serviceName.toString());
    debugPrint("p.serviceName.toString()");
      if (p.serviceName == type) {
        MobileOperatorList.value.add(p.operatorName);
        SpKeyOperaterList.value.add(p.spKey);
      }
      p.serviceName=="Recharge Plan";
      return true;
    }).toList();
    debugPrint(temp.toString());
    debugPrint("temp.toString()");
    debugPrint(MobileOperatorList.value.toString());
    if (MobileOperatorList.value.length > 1) {
      operator.value = MobileOperatorList.value[0];
      spKey.value = SpKeyOperaterList.value[0];
      return true;
    } else {
      debugPrint(MobileOperatorList.value.toString());
      debugPrint("MobileOperatorList.value.toString()");
      return false;
    }
  }

  void getCircleCode() async {
    var response = await APiProvider().getAllCircleList();
    debugPrint("34343534453454545343543543543543");
    if (response != null) {
      debugPrint("34343534453454545343543543543543");
      CircleCodeModal modal = response;
      debugPrint(modal.data.toString());
      debugPrint(modal.data[0].circleName.toString());

      tempcircleList = modal.data.obs;

      tempcircleList.where((element) {
        debugPrint(element.circleName.toString());
        debugPrint("element.circleName.toString()");
        circleList.add(element.circleName);
        return false;
      }).toList();
      ciccleCode.value = tempcircleList.value[0].circleCode.toString();
      debugPrint(circleList.value.toString());
      debugPrint("circleList.value.toString()");
    }
  }

  void viewPlan() async {
    // ShowCustomSnackBar().SuccessSnackBar("Please wait to see plans");
    debugPrint(spKey.value.toString());
      // RxString isDataLoaded=
   Get.dialog(
       Center(
         child: CircularProgressIndicator(),
       )
   ) ;

   await getPlan().then((value) {
      // Get.back();
      // Get.back();
      // Get.closeAllSnackbars();
         Navigator.pop(Get.context!);
      var titleName = SharedPrefrences().getTitleName();
      if (titleName == "Prepaid ") {
        Get.bottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            Obx(() => rechargePlanRechargeList.value.isNotEmpty
                ? Container(
                    // height:800,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: rechargePlanRechargeList.value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              height: 20,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: InkWell(
                                onTap: () {
                                  rechargePlanRechargeListDetail.value =
                                      rechargePlanRechargeList
                                          .value[index].pDetails;
                                  
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    rechargePlanRechargeList.value[index].pType,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 300,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount:
                                rechargePlanRechargeListDetail.value.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                child: ListTile(
                                  onTap: () {
                                    Get.back();
                                    selectedPlan.value =
                                        rechargePlanRechargeListDetail
                                            .value[index].rs
                                            .toString();
                                    rechargeAmount.value =
                                        rechargePlanRechargeListDetail
                                            .value[index].rs
                                            .toString();
                                  },
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Plan : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${rechargePlanRechargeListDetail.value[index].desc.toString()}",
// maxLines: 10,
                                        softWrap: true,
                                      )),
                                    ],
                                  ),
                                  subtitle: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Validity :  ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Text(
                                          rechargePlanRechargeListDetail
                                              .value[index].validity
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ],
                                  ),
                                  trailing: Text(
                                    "₹ ${rechargePlanRechargeListDetail.value[index].rs.toString()}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ]),
                  )
                : Container(
                    child: Center(
                      child: Image.asset("assets/images/noData.png"),
                    ),
                  )));
      //  ShowCustomSnackBar().ErrorSnackBar("In Prepaid BottomSheet");

      } else if (titleName == "DTH") {
        Get.bottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            Obx(() => dthPlanRechargeList.value.isNotEmpty
                ? Container(
                    // height:800,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dthPlanRechargeList.value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              height: 20,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: InkWell(
                                onTap: () {
                                  dthRechargeListDetail.value =
                                      dthPlanRechargeList.value[index].pDetials;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dthPlanRechargeList.value[index].pType,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 300,
                        color: Colors.grey.shade200,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: dthRechargeListDetail.value.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18.0, horizontal: 10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // border: Border.all(color: Colors.grey),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(  width:130,
                                                  child: Text(
                                                    "${dthRechargeListDetail.value[index].packageName}",
                                                    style: TextStyle(   overflow: TextOverflow.ellipsis,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                    "${dthRechargeListDetail.value[index].pChannelCount} | ${dthRechargeListDetail.value[index].pLangauge.toString().replaceAll("PLangauge.", "")}",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14))
                                              ],
                                            ),
                                            Container( width: 60,
                                              child: Text(
                                                  "${dthRechargeListDetail.value[index].pDescription}",style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                              ),),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        dthRechargeListDetail.value[index].price!=null?   SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 5, 5, 5),
                                                    primary: Colors.blue.shade50),
                                                onPressed: () {
                                                  if(dthRechargeListDetail.value[index].price?.monthly!=""){ selectedPlan.value=   dthRechargeListDetail.value[index].price!.monthly;
                                                  rechargeAmount.value=selectedPlan.value;
                                                  Get.back();}else{
                                                    ShowCustomSnackBar().SuccessSnackBar("Select Valid Plan");
                                                  }

                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Monthly",
                                                        style: TextStyle(
                                                            color: Colors.black38,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${ dthRechargeListDetail.value[index].price!.monthly}",
                                                      style: TextStyle(  overflow: TextOverflow.ellipsis,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  height: 30,
                                                  child: VerticalDivider(
                                                      color: Colors.black38,
                                                      thickness: 1)),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if(dthRechargeListDetail.value[index].price?.quarterly!=""){
                                                    selectedPlan.value=   dthRechargeListDetail.value[index].price!.quarterly;
                                                    rechargeAmount.value=selectedPlan.value;
                                                  Get.back();

                                                  }else{
                                                    ShowCustomSnackBar().SuccessSnackBar("Select Valid Plan");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 5, 5, 5),
                                                    primary: Colors.blue.shade50),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Quarterly",
                                                        style: TextStyle(
                                                            color: Colors.black38,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${ dthRechargeListDetail.value[index].price!.quarterly}",
                                                      style: TextStyle(
                                                          color: Colors.black, overflow: TextOverflow.ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  height: 30,
                                                  child: VerticalDivider(
                                                      color: Colors.black38,
                                                      thickness: 1)),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if(dthRechargeListDetail.value[index].price?.halfYearly!=""){ selectedPlan.value=   dthRechargeListDetail.value[index].price!.halfYearly;
                                                  rechargeAmount.value=selectedPlan.value;

                                                  Get.back();
                                                  }else{
                                                    ShowCustomSnackBar().SuccessSnackBar("Select Valid Plan");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 5, 5, 5),
                                                    primary: Colors.blue.shade50),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Haly Yearly",
                                                        style: TextStyle(
                                                            color: Colors.black38,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${ dthRechargeListDetail.value[index].price!.halfYearly}",
                                                      style: TextStyle(     overflow: TextOverflow.ellipsis,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  height: 30,
                                                  child: VerticalDivider(
                                                      color: Colors.black38,
                                                      thickness: 1)),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if(dthRechargeListDetail.value[index].price?.yearly!=""){ selectedPlan.value=   dthRechargeListDetail.value[index].price!.yearly;
                                                  rechargeAmount.value=selectedPlan.value;

                                                  Get.back();
                                                  }else{
                                                    ShowCustomSnackBar().SuccessSnackBar("Select Valid Plan");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 5, 5, 5),
                                                    primary: Colors.blue.shade50),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Yearly",
                                                        style: TextStyle(
                                                            color: Colors.black38,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      " ${dthRechargeListDetail.value[index].price!.yearly}",
                                                      style: TextStyle(    overflow: TextOverflow.ellipsis,
                                                          color:
                                                              Color(0xffE87CF5),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) :
                                        Container()
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        ),
                      )
                    ]),
                  )
                : Container(
                    child: Center(
                      child: Image.asset("assets/images/noData.png"),
                    ),
                  )));

      } else {
        ShowCustomSnackBar().ErrorSnackBar("Title Name is Not Correct");
      }
    });
  }

  Future<RxString> getPlan() async {
    var titleName = SharedPrefrences().getTitleName();
    var response = await APiProvider().getAllPlan();
    print("resposiiii" + response.toString());
    if (response != null) {
      var Url = "";
      print("titleName" + titleName + "asdads");
      print(titleName == "Prepaid");

      if (titleName == "Prepaid ") {
        VIewAllPlanModal modal = response;
        rechargePlanRechargeList.value = modal.data.data.data.types;
        rechargePlanRechargeListDetail.value =
            rechargePlanRechargeList.value.isNotEmpty
                ? rechargePlanRechargeList.value[0].pDetails
                : [];
      } else if (titleName == "DTH") {
        DthModel model = response;
        dthPlanRechargeList.value = model.data.data.data;
        dthRechargeListDetail.value = dthPlanRechargeList.value.isNotEmpty
            ? dthPlanRechargeList.value[0].pDetials
            : [];
      } else {
        ShowCustomSnackBar().ErrorSnackBar("Title Name is Not Correct");
      }

      debugPrint("modal.toString()");
    }
    debugPrint("modal.toString()");
    return "cdlkk".obs;
  }
}
