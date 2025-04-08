import 'package:collarchek/company_dashboard/company_dashboard_controllers.dart';
import 'package:get/get.dart';

class CompanyDashboardBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyDashboardControllers());
  }

}