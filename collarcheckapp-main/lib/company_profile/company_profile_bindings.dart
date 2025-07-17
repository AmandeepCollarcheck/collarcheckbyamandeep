import 'package:collarchek/company_profile/company_profile_controllers.dart';
import 'package:get/get.dart';

class CompanyProfileBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyProfileControllers());
  }

}