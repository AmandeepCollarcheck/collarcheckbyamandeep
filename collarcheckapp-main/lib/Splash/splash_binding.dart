import 'package:collarchek/Splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings{

  @override
  void dependencies() {
    //Get.lazyPut<SplashController>(() => SplashController());
    Get.put(SplashController());
  }
}