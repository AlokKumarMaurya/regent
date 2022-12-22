import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar {


 var customAppBar= PreferredSize(
        preferredSize: Size(MediaQuery.of(Get.context!).size.width,
            MediaQuery.of(Get.context!).size.height / 12.0),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(Get.context!).size.height / 12.0,
          decoration: BoxDecoration(color: Color(0xff194b7a)),
          child: Text("Mobile Recharge",style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),),
        ));

}
