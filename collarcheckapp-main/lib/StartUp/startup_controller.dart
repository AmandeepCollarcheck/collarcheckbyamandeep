import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';

class StartUpControllers extends GetxController{

  loginClick(){
    Get.toNamed(AppRoutes.login);
  }
  signUpButtonClick(){
    Get.toNamed(AppRoutes.startUpSignup);
  }
}