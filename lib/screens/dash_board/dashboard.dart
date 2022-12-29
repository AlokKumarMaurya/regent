import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regent/screens/recharge/recharge_home_page.dart';
import 'package:regent/utils/shred_prefrences/shared_prefrences.dart';
import 'package:regent/utils/snackbar.dart';
import 'package:shimmer/shimmer.dart';

import '../../getx_controller/dash_board_controller/all_recharege_type_controller.dart';
import '../../getx_controller/dash_board_controller/dashbora_controller.dart';
import '../../getx_controller/recharge_controller/recharhe_controller.dart';
import '../../utils/colors.dart';
import '../../utils/custom_textfield.dart';
import '../../utils/images.dart';
import 'drawer/left_drawer.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);

  DashboardController _dashboardController = Get.put(DashboardController());
  AllRechargeTypeController _allRechargeTypeController =
      Get.put(AllRechargeTypeController());
  List<String> images = [
    ConstantImage.banner1,
    ConstantImage.banner2,
    ConstantImage.banner3,
    ConstantImage.banner4,
    ConstantImage.banner5,
    ConstantImage.banner6,
  ];
  RechargeController _rechargeController = Get.put(RechargeController());
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
                // Color(0xffdac5fd),
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
      drawer: LeftDrawer(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            slider1(),
            const SizedBox(
              height: 20,
            ),
            testWidget(),
            // rechargeWidget(),
            // const SizedBox(
            //   height: 15,
            // ),
            // // myList(),
            // const SizedBox(
            //   height: 15,
            // ),
          ],
        ),
      ),
    );
  }
  List<Widget> _demo=[
    Container(height: 300,color: Colors.amber),
    Container(height: 300,color: Colors.black),
    Container(height: 300,color: Colors.blue),
    Container(height: 300,color: Colors.green),
  ];
  RxInt pageIndex=0.obs;
  Widget slider1(){
    return
     Obx(()=> Column(
       children: [
         CarouselSlider(
           options: CarouselOptions(
             height: 140.0,   onPageChanged: (int index,CarouselPageChangedReason){

             pageIndex.value=index;



           },
             reverse: false,
             viewportFraction: 1.0,
             initialPage: 0,
             autoPlay: true,),
           items:images.map((i) {
             return Builder(
               builder: (BuildContext context) {
                 return Container(

                     margin: EdgeInsets.symmetric(horizontal: 5.0),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: Image.asset(i,fit: BoxFit.contain,)
                 );
               },
             );
           }).toList(),
         ),
         CarouselIndicator(
           
           color: Colors.grey,  activeColor: Colors.yellow, space: 3,
           count: images.length,
           index: pageIndex.value,
         ),
       ],
     ));
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
              SizedBox(
                height: 10,
              ),
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
                    // onTap: () => Get.to(RechargeHomePage("test")),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/mobile.png",
                            height: 40,
                            width: 40,
                          ),
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
                        Image.asset(
                          "assets/images/landLine.png",
                          height: 40,
                          width: 40,
                        ),
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
                        Image.asset(
                          "assets/images/light.png",
                          height: 40,
                          width: 40,
                        ),
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
                        Image.asset(
                          "assets/images/more.png",
                          height: 40,
                          width: 40,
                        ),
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
                        Image.asset(
                          "assets/images/movie.png",
                          height: 40,
                          width: 40,
                        ),
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
                        Image.asset(
                          "assets/images/flight.png",
                          height: 40,
                          width: 40,
                        ),
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
                        Image.asset(
                          "assets/images/train.png",
                          height: 40,
                          width: 40,
                        ),
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
                        Image.asset(
                          "assets/images/more.png",
                          height: 40,
                          width: 40,
                        ),
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
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "DTH Recharge",
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                color: AppColors.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Text(
                                          "9795541088",
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                color: AppColors.textColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "Due Date 18 Jan 2023",
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Pay Now",
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            )
                          ],
                        ),
                      );
                    }),
              ],
            )),
      ),
    );
  }

  Widget testWidget() {
    debugPrint(_allRechargeTypeController.allRechargeList.value.length
        .toString());
    debugPrint(
        "_allRechargeTypeController.allRechargeList.value.length.toString()");
    return Obx(()=>(_allRechargeTypeController.allRechargeList.isNotEmpty?Container(
      child: ListView.builder(
        itemCount: _allRechargeTypeController.allRechargeList.value.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          debugPrint(_allRechargeTypeController.allRechargeList.value.length
              .toString());
          debugPrint(
              "_allRechargeTypeController.allRechargeList.value.length.toString()");
          return (_allRechargeTypeController
              .allRechargeList.value[index].data.length!=0)?Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 15),
                  width:MediaQuery.of(context).size.width ,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "${_allRechargeTypeController.allRechargeList.value[index].name}",style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 25,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount:_allRechargeTypeController
                        .allRechargeList.value[index].data.length ,
                    itemBuilder: (context, gridindex) {
                      debugPrint(_allRechargeTypeController
                          .allRechargeList.value[index].data.length
                          .toString());
                      debugPrint("_allRechargeTypeController.allRechargeList.value[index].data.length.toString()");
                      return InkWell(
                        onTap: () {


                          debugPrint(_allRechargeTypeController.allRechargeList.value[index].data[gridindex].op_name.toString());
                          debugPrint("_allRechargeTypeController.allRechargeList.value[index].data[gridindex].op_name.toString()");
                         bool temp= _rechargeController.filterOperatorList(_allRechargeTypeController.allRechargeList.value[index].data[gridindex].op_name.toString());
                            temp?   Get.to(RechargeHomePage(title: "${_allRechargeTypeController.allRechargeList.value[index].data[gridindex].name}",)):ShowCustomSnackBar().SuccessSnackBar("Service Coming Soon");

                          SharedPrefrences().saveTitleName(_allRechargeTypeController.allRechargeList.value[index].data[gridindex].name??"--") ;

                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration:BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffede7f8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                      "https://softfix.in/demo/mxepay/public/operators/${_allRechargeTypeController.allRechargeList.value[index].data[gridindex].image}",height: 40,width: 40,errorBuilder: (context, error, stackTrace) =>Image.asset(ConstantImage.logo,width: 40,height: 40,),),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Text(
                                        textAlign: TextAlign.center,
                                    "${_allRechargeTypeController.allRechargeList.value[index].data[gridindex].name}",overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ):SizedBox();
        },
      ),
    ):
    ShimmerWidget()
    
    ));
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
      Widget ShimmerWidget(){
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recharge",style:TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
      ),),
          SizedBox(height: 20,),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5.0,      childAspectRatio: 4/4.5,
                mainAxisSpacing: 15.0,
              ),
              itemCount:4 ,
              itemBuilder: (context, gridindex) {

                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(    height:55,     width: 55,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffede7f8),
                        ),
                      
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Regent Pay",overflow: TextOverflow.ellipsis,),
                      )
                    ],
                  ),
                );
              }),
          SizedBox(height: 20,),
          Text("Utility",style:TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
      ),),
          SizedBox(height: 20,),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 15.0,   childAspectRatio: 4/4.5,
              ),
              itemCount:12 ,
              itemBuilder: (context, gridindex) {

                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(    height:55,     width: 55,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffede7f8),
                        ),

                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Regent Pay",overflow: TextOverflow.ellipsis,),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    ),
  );
      }