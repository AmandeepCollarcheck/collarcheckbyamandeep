import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';

class StartUpSignupController extends GetxController{


  loginButtonClick(){
    Get.toNamed(AppRoutes.login);
  }

  companySignUpClick(){
    Get.toNamed(AppRoutes.signup,arguments: {"isCompanyProfile":true});
  }
  individualSignUpClick(){
    Get.toNamed(AppRoutes.signup,arguments: {"isCompanyProfile":false});
  }
  backClick(){
    Get.offNamed(AppRoutes.startup);
  }
}