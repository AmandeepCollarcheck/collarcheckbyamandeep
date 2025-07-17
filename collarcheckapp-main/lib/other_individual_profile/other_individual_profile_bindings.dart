import 'package:collarchek/other_individual_profile/other_individula_profile_controllers.dart';
import 'package:get/get.dart';

class OtherIndividualProfileBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(OtherIndividualProfileControllers());
  }

}