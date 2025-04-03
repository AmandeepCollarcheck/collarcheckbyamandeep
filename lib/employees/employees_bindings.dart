import 'package:get/get.dart';

import 'employees_controllers.dart';

class EmployeesBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(EmployeeControllers());
  }

}