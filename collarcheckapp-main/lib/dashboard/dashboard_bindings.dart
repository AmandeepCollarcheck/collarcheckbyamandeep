import 'package:collarchek/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.find<DashboardController>();
  }
}