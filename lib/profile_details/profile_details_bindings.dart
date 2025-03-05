import 'package:collarchek/profile_details/profile_details_controllers.dart';
import 'package:get/get.dart';

class ProfileDetailsBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileDetailsControllers());
  }

}