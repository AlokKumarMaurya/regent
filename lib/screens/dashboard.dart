import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regent/screens/recharge/recharge_home_page.dart';

import '../getx_controller/dashbora_controller.dart';
import '../getx_controller/recharge_controller/recharhe_controller.dart';
import '../utils/colors.dart';
import '../utils/custom_textfield.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);

  DashboardController _dashboardController = Get.put(DashboardController());

  List<String> images = ["assets/images/slider_image1.jpg",
    "assets/images/slider_image2.jpg"];
  RechargeController _rechargeController=Get.put(RechargeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfbfb),
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
          "Regent Pay",
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            slider(),
            const SizedBox(
              height: 20,
            ),
            rechargeWidget(),
            const SizedBox(
              height: 15,
            ),
            // myList(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Column(
      children: [
        Obx(() => SizedBox(
              height: 160,
              width: double.infinity,
              child: PageView.builder(
                  itemCount: images.length,
                  pageSnapping: true,
                  controller: _dashboardController.pageController.value,
                  onPageChanged: (page) {
                    _dashboardController.activePage.value = page;
                  },
                  itemBuilder: (context, pagePosition) {
                    // _dashboardController.activePage.value = pagePosition;
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6)),
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(
                          images[pagePosition],
                          fit: BoxFit.fill,
                        ));
                  }),
            )),
        Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(
                images.length, _dashboardController.activePage.value)))
      ],
    );
  }

  Widget rechargeWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.11),
              spreadRadius: 3,
              blurRadius: 11,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                "Recharge & Bill Payments",
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=>Get.to(RechargeHomePage()),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        children: [
                          Image.asset("assets/images/mobile.png",height: 40,width:
                            40,),
                          const SizedBox(
                            height: 6,
                          ),
                          AppText(
                            title: 'Mobile',
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Image.asset("assets/images/landLine.png",height: 40,width:
                        40,),
                        const SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'Landline',
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Image.asset("assets/images/light.png",height: 40,width:
                        40,),
                        const SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'Electricity',
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        // Image.asset("assets/images/more.png"),
                        Image.asset("assets/images/more.png",height: 40,width:
                        40,),
                        SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'More',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Book & FastTag",
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Image.asset("assets/images/movie.png",height: 40,width:
                        40,),
                        const SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'Movies',
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Image.asset("assets/images/flight.png",height: 40,width:
                        40,),
                        const SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'Flights',
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Image.asset("assets/images/train.png",height: 40,width:
                        40,),
                        const SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'Trains',
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      children: [
                        Image.asset("assets/images/more.png",height: 40,width:
                        40,),
                        SizedBox(
                          height: 6,
                        ),
                        AppText(
                          title: 'Landline',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Payments",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb,
                                      size: 40,
                                      color: AppColors.greenColor,
                                    ),
                                    SizedBox(width: 13,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("DTH Recharge",style: GoogleFonts.quicksand(
                                          textStyle: const TextStyle(
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),),
                                        Text("9795541088",style: GoogleFonts.quicksand(
                                          textStyle: const TextStyle(
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),),
                                        Text("Due Date 18 Jan 2023",style: GoogleFonts.quicksand(
                                          textStyle: const TextStyle(
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),),
                                      ],
                                    ),
                                  ],
                                ),

                                Text("Pay Now",style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),),
                              ],
                            ),
                            SizedBox(height: 6,),
                            Divider(thickness: 1,color: AppColors.greyColor,)
                          ],
                        ),
                      );
                    }),
              ],
            )),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Color(0xff331271) : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }
}
