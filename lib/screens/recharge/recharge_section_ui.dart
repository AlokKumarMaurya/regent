import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../getx_controller/login_controller/login_controller.dart';
import '../../getx_controller/recharge_controller/recharhe_controller.dart';
import '../../utils/colors.dart';
import '../../utils/commom_widget/custom_text_filed.dart';
import '../../utils/shred_prefrences/shared_prefrences.dart';

class RechargeSectionUi extends StatelessWidget {
  RechargeSectionUi({Key? key}) : super(key: key);
  RechargeController _rechargeController = Get.put(RechargeController());
  LoginController _loginController = Get.put(LoginController());
    RxString test="Phone Number".obs;
  @override
  Widget build(BuildContext context) {
    var titleName = SharedPrefrences().getTitleName();

    if (titleName == "Prepaid ") {
      test.value="Phone Number";
    } else if (titleName == "DTH") {
      test.value="Customer Id";
    }

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.09),
                spreadRadius: 3,
                blurRadius: 11,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomContainer(
                  headingName: "Operator",
                  yourWidget: DropDownContainer(
                      dropdownHeading: "",
                      dropDownList:
                          _rechargeController.MobileOperatorList.value,
                      on_drop_down_change: (val) {
                        debugPrint(val.toString());
                        _rechargeController.operator.value = val.toString();
                        // _rechargeController.spKey.value
                        var a = _rechargeController.allOperatorList.value
                            .where((element) {
                          debugPrint(element.spKey);
                          if (_rechargeController.operator.value ==
                              element.operatorName) {
                            _rechargeController.spKey.value =
                                element.spKey.toString();
                          }
                          _rechargeController.operator.value ==
                              element.operatorName;
                          return true;
                        });
                        debugPrint(a.toString());
                        debugPrint(_rechargeController.spKey.value.toString());
                        debugPrint(
                            "_rechargeController.spKey.value.toString()");
                      },
                      dropDownInitialValue:
                          "${_rechargeController.MobileOperatorList.value[0]}"
                              .obs)),
              const SizedBox(
                height: 25,
              ),

              CustomContainer(
                  headingName: "Circle Code",
                  yourWidget: DropDownContainer(
                      dropdownHeading: "Select Circle",
                      dropDownList: _rechargeController.circleList.value,
                      on_drop_down_change: (val) {
                        _rechargeController.selectedCircle.value =
                            val.toString();
                        var a = _rechargeController.tempcircleList.value
                            .where((element) {
                          if (element.circleName ==
                              _rechargeController.selectedCircle.value) {
                            _rechargeController.ciccleCode.value =
                                element.circleCode.toString();
                          }
                          return true;
                        });
                        debugPrint(a.toString());
                        debugPrint(_rechargeController.ciccleCode.value);
                      },
                      dropDownInitialValue:
                          "${_rechargeController.circleList.value[0]}".obs)),

              // CustomTextField(
              //   headingName: "Customer Id",
              //   hinttext: "${_rechargeController.id}",
              //   onTextFieldChange: (val) => debugPrint(val.toString()),
              // ) ,
              const SizedBox(
                height: 25,
              ),

              // CustomContainer(headingName: "Amount", yourWidget: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("${_rechargeController.rechargeAmount.value}")  ,
              //     Row(
              //       children: [
              //         TextButton(onPressed: (){}, child:Text("See all plans",style:  GoogleFonts.quicksand(
              //           textStyle: const TextStyle(
              //               color: AppColors.colourdtext,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20),
              //         ),)),
              //         Icon(Icons.navigate_next,color: AppColors.colourdtext,)
              //       ],
              //     )
              //   ],
              // )) ,

              // CustomTextField(
              //     headingName: "Amount",
              //     hinttext: _rechargeController.rechargeAmount.value,
              //     onTextFieldChange: (val) {
              //       _rechargeController.rechargeAmount.value=val;
              //     }
              // ) ,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Amount",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                        color: AppColors.colourdtext,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() =>
                        Text("${_rechargeController.selectedPlan.value}")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5)),
                        onPressed: () => _rechargeController.viewPlan(),
                        child: Text(
                          "View Plan",
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                        ))
                  ],
                ),
              ),

              SizedBox(
                height: 25,
              ),
              Obx(()=>CustomTextField(
                  lengthInput: LengthLimitingTextInputFormatter(10),
                  inputType: TextInputType.number,
                  headingName: test.value,
                  hinttext: _rechargeController.number,
                  onTextFieldChange: (val) {
                    debugPrint(_rechargeController.number.value);
                    _rechargeController.number.value = val;
                  })),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              _rechargeController.doRecharge();
            },
            child: Text("Recharge"))
      ],
    );
  }
}
