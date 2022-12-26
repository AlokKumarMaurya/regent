import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.headingName,
      required this.hinttext,
      required this.onTextFieldChange(String a)})
      : super(key: key);
  String headingName;
  String hinttext;
  Function onTextFieldChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      // decoration: BoxDecoration(
      //   color: Color(0xffffffff),
      //   borderRadius: BorderRadius.circular(6),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.09),
      //       spreadRadius: 3,
      //       blurRadius: 11,
      //       offset: const Offset(0, 1),
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headingName,
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                  color: AppColors.colourdtext,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          TextFormField(
            onChanged: (val) => onTextFieldChange(val),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              hintStyle: TextStyle(
                  color: AppColors.colourdtext,
                  fontWeight: FontWeight.normal,
                  fontSize: 13),
            ),
          ),
          Divider(
            color: AppColors.colourdtext,
            height: 4,
          )
        ],
      ),
    );
  }
}

class DropDownContainer extends StatelessWidget {
  const DropDownContainer(
      {Key? key,
      required this.dropdownHeading,
      required this.dropDownList,
      required this.on_drop_down_change,
      required this.dropDownInitialValue})
      : super(key: key);
  final String dropdownHeading;
  final RxString dropDownInitialValue;
  final List dropDownList;
  final Function on_drop_down_change;
  @override
  Widget build(BuildContext context) {
    RxDouble filedHeight = 100.0.obs;
    RxDouble widt = 10.0.obs;
    filedHeight.value = MediaQuery.of(context).size.height / 9;
    widt.value = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "${dropdownHeading}",
        //   style: GoogleFonts.quicksand(
        //     textStyle: const TextStyle(
        //         color: AppColors.colourdtext,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 16),
        //   ),
        // ),
        SizedBox(height: 3,),
        Obx(() => Container(
          height: 30,
            padding: EdgeInsets.only(left: 5),
            width: widt.value,
            child: DropdownButtonHideUnderline(
                child:
                DropdownButton2(
                    isExpanded: true,
                    value: dropDownInitialValue.value,
                    // style: TextStyle(
                    //   overflow: TextOverflow.ellipsis,
                    //   color: Colors.black,
                    //   fontSize: 15
                    // ),
                    hint: Text(
                      "Select value",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            color: AppColors.colourdtext,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    items: dropDownList.map((e) {
                      return DropdownMenuItem(
                          value: e.toString(), child: Text(e.toString()));
                    }).toList(),
                    onChanged: (val) {
                      on_drop_down_change(val.toString());
                      dropDownInitialValue.value = val.toString();
                    })
            ))),
      ],
    );
  }
}


class CustomContainer extends StatelessWidget {
   CustomContainer({Key? key,required this.headingName,required this.yourWidget}) : super(key: key);
   String  headingName;
   Widget yourWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      // decoration: BoxDecoration(
      //   color: Color(0xffffffff),
      //   borderRadius: BorderRadius.circular(6),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.09),
      //       spreadRadius: 3,
      //       blurRadius: 11,
      //       offset: const Offset(0, 1),
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headingName,
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                  color: AppColors.colourdtext,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          yourWidget,
          Divider(
            color: AppColors.colourdtext,
            height: 4,
          )
        ],
      ),
    );
  }
}


