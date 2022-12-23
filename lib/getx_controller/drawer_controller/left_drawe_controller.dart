import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/login_page.dart';
import '../../utils/shred_prefrences/shared_prefrences.dart';

class LeftDraweController extends GetxController{

   RxString name="".obs;

  void handleLogout(){
    debugPrint("logOut tap");
    SharedPrefrences().saveLoginStatus(false);
    Get.offAll(LoginPage());
  }
  getUserName()async{
    name.value=await SharedPrefrences().getName();
  }

        @override
  void onInit() {
    getUserName();
    // TODO: implement onInit
    super.onInit();
  }

}