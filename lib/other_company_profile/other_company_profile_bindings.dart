import 'package:collarchek/other_company_profile/other_company_profile_controllers.dart';
import 'package:get/get.dart';

class OtherCompanyProfileBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(OtherCompanyProfileControllers());
  }

}