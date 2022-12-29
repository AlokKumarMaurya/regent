import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:regent/screens/dash_board/dashboard.dart';
import 'package:regent/screens/login_page.dart';
import 'package:regent/utils/images.dart';
import 'package:regent/utils/shred_prefrences/shared_prefrences.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override

  RxBool isLoggedIn=false.obs;


  getLoggedInStatus()async{
    isLoggedIn.value=await SharedPrefrences().getLogin();
    debugPrint(isLoggedIn.value.toString()) ;
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => (isLoggedIn.value)?DashBoard():LoginPage()), (e) => false);
    });
  }


  void initState() {
    getLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(
            children: [
              Container(    width:Get.width , height: Get.height,
                child:  Image.asset("assets/images/splashback.png",fit: BoxFit.cover ,) ,
              ),
              Center(
                  child: Image.asset(
                   "assets/images/splashGif.gif",
                scale: 4,
              )),
            ],
          ),
        ));
  }
}
