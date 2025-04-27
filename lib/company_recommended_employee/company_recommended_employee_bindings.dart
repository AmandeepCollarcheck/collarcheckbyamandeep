import 'package:collarchek/company_recommended_employee/company_recommended_employee_controllers.dart';
import 'package:get/get.dart';

class CompanyRecommendedEmployeeBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyRecommendedEmployeeControllers());
  }

}