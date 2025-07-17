import 'package:collarchek/Login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    //Get.lazyPut<LoginControllers>(() => LoginControllers());
    Get.put(LoginControllers());
  }
}