import 'package:collarchek/educations/education_controllers.dart';
import 'package:get/get.dart';

class EducationBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EducationControllers());
  }

}