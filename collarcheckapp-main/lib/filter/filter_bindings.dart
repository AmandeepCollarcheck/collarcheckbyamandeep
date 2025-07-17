import 'package:collarchek/filter/filter_controller.dart';
import 'package:get/get.dart';

class FilterBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(FilterController());
  }
}