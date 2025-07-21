import 'package:collarchek/company_update_profile/company_update_profile_controllers.dart';
import 'package:get/get.dart';

class CompanyUpdateProfileBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyUpdateProfileControllers());
  }

}