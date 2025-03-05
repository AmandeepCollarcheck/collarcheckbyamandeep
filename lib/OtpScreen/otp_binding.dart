import 'package:collarchek/OtpScreen/otp_controller.dart';
import 'package:get/get.dart';

class OtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OtpController());
    //Get.lazyPut<OtpController>(() => OtpController());
    //Get.lazyPut<OtpController>(()=>OtpController());
  }
}