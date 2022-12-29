import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../getx_controller/drawer_controller/transaction_report_contoller/transaction_report_controller.dart';
import '../../utils/colors.dart';

class TransactionReports extends StatelessWidget {
   TransactionReports({Key? key}) : super(key: key);
  TransactionReport transactionReport=Get.put(TransactionReport());
  @override
  Widget build(BuildContext context) {
    debugPrint("transactionReport.historyList.length.toString()"+transactionReport.historyList.length.toString());
    return  Scaffold(   backgroundColor: Colors.grey.shade100,
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
            "Transaction Report",
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          centerTitle: true,
        
        ),
      body: SingleChildScrollView(
        child: Obx(()=>transactionReport.historyList.isNotEmpty?Column(

          children: [
            ListView.builder(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactionReport.historyList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.09),
                        spreadRadius: 3,
                        blurRadius: 11,
                        offset: const Offset(0, 1),
                      )],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text("${transactionReport.historyList[index].accountNo}"),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Trans Id: ${transactionReport.historyList[index].transactionId}",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12),),
                        Text("User Id: ${transactionReport.historyList[index].userId}",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12)),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Text("₹ ${transactionReport.historyList[index].amount}", style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff6ffc2d)),
                        ),) ,
                                   SizedBox(height: 10,),

                        Text("₹ ${transactionReport.historyList[index].status}", style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(0xff6ffc2d)),
                        ),)
                      ],
                    ),
                  ),
                );
              },)
          ],
        ):Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(heightFactor: 20,child: Text("No Transaction History"),),
          ],
        )),
      ),
    );
  }
}
