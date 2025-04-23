import 'package:collarchek/edit_benefit/edit_benefit_controllers.dart';
import 'package:get/get.dart';

class EditBenefitBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EditBeneFitControllers());
  }

}