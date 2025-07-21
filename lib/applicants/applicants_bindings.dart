import 'package:collarchek/applicants/applicants_controllers.dart';
import 'package:get/get.dart';

class ApplicantsBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ApplicantsControllers());
  }

}