import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SharedPrefrences{
  final box = GetStorage();


  static const loginKey="Login";
   static const idPref="idPref";
   static const nameKey="Name";
   static const titleName="TitleName";


  void saveLoginStatus(bool setValue){
               box.write(loginKey,setValue);
               debugPrint(setValue.toString());
  }


  bool getLogin(){
    debugPrint(box.read(loginKey).toString());
  return  box.read(loginKey)??false;
  }


  void saveId(String id){
    box.write(idPref, id);
  }
  void saveTitleName(String title){
    box.write(titleName, title);
  }

  String getTitleName(){
    return box.read(titleName)??"";
  }
 String getIdofUser(){
    return box.read(idPref)??"";
  }


  void saveName(String name){
    box.write(nameKey, name) ;
  }

  String getName(){
    return box.read(nameKey)??"";
  }
}