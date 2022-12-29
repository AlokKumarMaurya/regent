import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../getx_controller/dash_board_controller/all_recharege_type_controller.dart';
import '../../../getx_controller/drawer_controller/left_drawe_controller.dart';
import '../../../getx_controller/login_controller/login_controller.dart';
import '../../../utils/commom_widget/lsit_tile.dart';
import '../../../utils/images.dart';
import '../../drawer screens/transaction_report_screen.dart';

class LeftDrawer extends StatelessWidget {
  LeftDrawer({Key? key}) : super(key: key);

  TextStyle draweTitleStyle = GoogleFonts.quicksand(
      color: Color(0xff4c1b80), fontSize: 17, fontWeight: FontWeight.w600);

  LeftDraweController _leftDraweController = Get.put(LeftDraweController());
  LoginController _loginController=Get.put(LoginController());
  AllRechargeTypeController _allRechargeTypeController=Get.put(AllRechargeTypeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(color: Color(0xff500dc0)),
                child: UserAccountsDrawerHeader( currentAccountPictureSize: Size(60,60),
                  // currentAccountPictureSize: Size.fromWidth(100),
                    decoration: BoxDecoration(color: Color(0xff500dc0)),
                    currentAccountPicture: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ConstantImage.logo,),
                    ),
                    accountName:                   Text("${_leftDraweController.name.value}",

                      // Text("${_loginController.loginDetails.value!.data[0].name}",
                      style: TextStyle(
                      fontSize: 15
                    ),),
                    accountEmail: Text("",maxLines: 2,)
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context)
                    .size
                    .width, // padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CustomListTile(
                        titleWidget: Text(
                          "Dashboard",
                          style: draweTitleStyle,
                        ),
                        handle_tap: (){},
                        leadingWidget:Image.asset(ConstantImage.dashBoard,height: 30,width: 30,)),
                    CustomListTile(
                        handle_tap: (){},
                        titleWidget: Text(
                          "Profile",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.profile,height: 30,width: 30,)),
                    CustomListTile(
                        handle_tap: (){},
                        titleWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Wallet",
                              style: draweTitleStyle,
                            ),
                            SizedBox(width: 5,),
                            Obx(()=>Text("₹ ${_allRechargeTypeController.balance.value}",style: TextStyle(
                              color: Colors.green,fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),)) ,

                          ],
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.wallet,height: 25,width: 25,)),
                    CustomListTile(
                        handle_tap: (){},
                        titleWidget: Text(
                          "Set PIN",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.setPin,height: 25,width: 25,)),
                    CustomListTile(
                        handle_tap: ()=>_leftDraweController.handleLogout(),
                        titleWidget: Text(
                          "LogOut",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.logout,height: 30,width: 30,)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(color: Colors.black, height: 4),

              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    CustomListTile(
                        handle_tap: (){
                          Get.to(()=>TransactionReports());
                        },
                        titleWidget: Text(
                          "Transaction Report",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.transactionReport,height: 30,width: 30,)),


                    CustomListTile(
                        handle_tap: (){},
                        titleWidget: Text(
                          "Recharge Report",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.rechargeReport,height: 25,width: 25,)),

                    CustomListTile(
                        handle_tap: (){},
                        titleWidget: Text(
                          "Tell a friend",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.tellAFriend,height: 25,width: 25,)),
                    CustomListTile(
                        handle_tap: (){},
                        titleWidget: Text(
                          "Help and feedback",
                          style: draweTitleStyle,
                        ),
                        leadingWidget:
                        Image.asset(ConstantImage.helpCenter,height: 30,width: 30,)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
