import 'package:collarchek/SignUp/signup_controllers.dart';
import 'package:get/get.dart';

class SignUpBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SignUpControllers());
    //Get.lazyPut<SignUpControllers>(() => SignUpControllers());
  }
}