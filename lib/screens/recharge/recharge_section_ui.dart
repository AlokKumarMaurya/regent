import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../getx_controller/login_controller/login_controller.dart';
import '../../getx_controller/recharge_controller/recharhe_controller.dart';
import '../../utils/colors.dart';
import '../../utils/commom_widget/custom_text_filed.dart';

class RechargeSectionUi extends StatelessWidget {
   RechargeSectionUi({Key? key}) : super(key: key);
  RechargeController _rechargeController=Get.put(RechargeController());
   LoginController _loginController=Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
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
              SizedBox(
                height: 20,
              ),
              CustomContainer(
                  headingName: "Operator",
                  yourWidget: DropDownContainer(
                      dropdownHeading: "",
                      dropDownList: _rechargeController.MobileOperatorList.value,
                      on_drop_down_change: (val){
                        _rechargeController.operator.value=val.toString();
                      },
                      dropDownInitialValue: "${_rechargeController.MobileOperatorList.value[0]}".obs)),
              SizedBox(height: 25,),

              CustomContainer(
                  headingName: "Circle Code",
                  yourWidget: DropDownContainer(
                      dropdownHeading: "",
                      dropDownList: _rechargeController.circleList.value,
                      on_drop_down_change: (val){
                        _rechargeController.selectedCircle.value=val.toString();
                      },
                      dropDownInitialValue: "${_rechargeController.circleList.value[0]}".obs)),




              // CustomTextField(
              //   headingName: "Customer Id",
              //   hinttext: "${_rechargeController.id}",
              //   onTextFieldChange: (val) => debugPrint(val.toString()),
              // ) ,
              SizedBox(height: 25,),
              
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

              CustomTextField(
                  headingName: "Amount",
                  hinttext: "${_rechargeController.rechargeAmount.value}",
                  onTextFieldChange: (val) {
                    _rechargeController.rechargeAmount.value=val;
                  }

              ) ,


              SizedBox(height: 25,),
              CustomTextField(
                headingName: "Phone number",
                hinttext: "${_rechargeController.number.value}",
                onTextFieldChange: (val) {
                  _rechargeController.number.value=val;
    }

              ) ,
              
            ],
          ),
        ),
        SizedBox(height: 30,),
        ElevatedButton(onPressed: (){
          _rechargeController.doRecharge();
        }, child:Text("Recharge"))
      ],
    );
  }
}
