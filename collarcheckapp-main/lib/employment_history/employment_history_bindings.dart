import 'package:collarchek/employment_history/employment_history_controllers.dart';
import 'package:get/get.dart';

class EmploymentHistoryBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EmploymentHistoryControllers());
  }

}