import 'package:collarchek/StartSignUp/start_signup_controller.dart';
import 'package:get/get.dart';

class StartSignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StartUpSignupController());
  }
}