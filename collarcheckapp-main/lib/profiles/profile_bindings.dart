import 'package:collarchek/profiles/profile_controllers.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileControllers());
  }
}