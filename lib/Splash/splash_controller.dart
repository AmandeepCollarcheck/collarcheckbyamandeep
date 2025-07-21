import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import '../utills/app_key_constent.dart';
import '../utills/image_path.dart';

class SplashController extends GetxController{





  @override
  void onInit() {
    _checkDeviceIdAvailableOrNot();


    super.onInit();
  }




   _checkDeviceIdAvailableOrNot() async{
     //await GetStorage().erase();
     String accessToken =  GetStorage().read(deviceAccessToken)??"";
     Future.delayed(Duration(seconds: 3), () {
       if(accessToken!=null&&accessToken.isNotEmpty){
         Get.offNamed(AppRoutes.bottomNavBar);
         //Get.offNamed(AppRoutes.startup);
       }else{
         Get.offNamed(AppRoutes.startup);
     }
     });
   }
}