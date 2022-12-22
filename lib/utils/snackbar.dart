import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCustomSnackBar{
  void SuccessSnackBar(String message){
    Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          messageText: Text(message,style:TextStyle(
            color: Colors.white,
          )),
        )
    );
  }




  void ErrorSnackBar(String message){
    // Get.closeAllSnackbars();
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.red,
      duration: Duration(
          seconds: 2
      ),
      messageText: Text(message,style: TextStyle(
          color: Colors.white
      ),),
    ));
  }
}