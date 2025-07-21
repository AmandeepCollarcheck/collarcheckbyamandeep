import 'package:collarchek/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:get/get.dart';

class BottomNavBarBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(BottomNavBarController());
  }
}