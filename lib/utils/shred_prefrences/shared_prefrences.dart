import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SharedPrefrences{
  final box = GetStorage();


  static const loginKey="Login";
   static const idPref="idPref";
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

  String getIdofUser(){
    return box.read(idPref)??"";
  }
}