import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regent/getx_controller/login_controller/login_controller.dart';
import 'package:regent/utils/colors.dart';

import '../utils/custom_textfield.dart';
import '../utils/images.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
   //   backgroundColor: Color(0xff307a92),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
              Color(0xff307a92),
            ],
),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              ConstantImage.logo,
              scale: 2,
            )),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      AppText(
                        title: 'User ID:',
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Obx(() => AppTextField(
                            hint: 'Enter your userId',
                            controller: _loginController.userId.value,
                            textCapitalization: TextCapitalization.none,
                            textInputType: TextInputType.text,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      AppText(
                        title: 'Password:',
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Obx(() => AppTextField(
                            hint: 'Enter your password',
                            controller: _loginController.password.value,
                            textCapitalization: TextCapitalization.none,
                            textInputType: TextInputType.text,
                          )),
                      const SizedBox(
                        height: 60,
                      ),
                      InkWell(
                        onTap: () {
                          _loginController.loginData();
                        },
                        child: Center(
                          child: Container(
                            height: 45,
                            width: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff500dc0),
                                  Color(0xff331271),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
