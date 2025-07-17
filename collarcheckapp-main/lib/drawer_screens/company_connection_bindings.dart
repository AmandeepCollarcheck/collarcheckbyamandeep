import 'package:collarchek/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

import 'company_connection_controller.dart';

class CompanyConnectionBindings extends Bindings{


  @override
  void dependencies() {
    // Get.lazyPut<DashboardController>(() => DashboardController());
    //Get.put(CompanyConnectionControllers);

    Get.put(CompanyConnectionControllers());


  }
}