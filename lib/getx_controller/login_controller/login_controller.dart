import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regent/utils/shred_prefrences/shared_prefrences.dart';

import '../../api_utility/api_client.dart';
import '../../screens/dash_board/dashboard.dart';
import '../../utils/commom_widget/common_widget.dart';
import '../../utils/modal/login_modal.dart';
import '../../utils/snackbar.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> userId = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
   var loginDetails=Rxn<LoginModal>();
  void loginData() {
    if (userId.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your user ID");
    } else if (password.value.text.isEmpty) {
      ShowCustomSnackBar().ErrorSnackBar("Enter your Password");
    } else {
        hitApi();
    }
  }

  void hitApi() async {
    CommonWidget().showLoader();
    var response = await APiProvider().login();
    if (response != null) {
      LoginModal modal=response;
      loginDetails.value=modal;
      SharedPrefrences().saveLoginStatus(true);
      SharedPrefrences().saveId(modal.data[0].id.toString());
      SharedPrefrences().saveName(modal.data[0].name.toString()) ;
      Get.back();
      Get.offAll(DashBoard());
      ShowCustomSnackBar().SuccessSnackBar(modal.message.toString());
    }
  }
}
