import 'package:collarchek/account_verification/account_verification_controllers.dart';
import 'package:get/get.dart';

class AccountVerificationBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AccountVerificationControllers());
  }

}