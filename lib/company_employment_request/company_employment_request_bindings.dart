import 'package:collarchek/company_employment_request/company_employment_request_controllers.dart';
import 'package:get/get.dart';

class CompanyEmploymentRequestBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyEmploymentRequestControllers());
  }

}