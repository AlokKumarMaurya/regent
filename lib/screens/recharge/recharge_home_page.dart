import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:regent/screens/recharge/recharge_section_ui.dart';

import '../../utils/app_bar/custom_app_bar.dart';
 import "package:flutter/material.dart";

import '../../utils/colors.dart';
class RechargeHomePage extends StatelessWidget {
  String title;
   RechargeHomePage({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff500dc0),
                Color(0xff331271),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: Text(
          "$title",
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        centerTitle: true,
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body:SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            RechargeSectionUi(),
          ],
        )
      )
    );
  }
}
