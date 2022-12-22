import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt activePage = 1.obs;
  RxBool pageChange = false.obs;
  var pageController = Rx<PageController?>(null);
  set pageController1(value) => pageController.value = value;
  get pageController1 => pageController.value;

  @override
  void onInit() {
    pageController1 = PageController(viewportFraction: 0.8, initialPage: 1);

    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (activePage.value < 2) {
        activePage.value++;
        pageController.value!.animateToPage(
          activePage.value,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        activePage.value = 1;
      }
      super.onInit();
    });
  }
}
