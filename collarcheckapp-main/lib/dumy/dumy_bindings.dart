import 'package:get/get.dart';

import 'dumy_controllers.dart';

class DumyBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TabControllerX());
  }

}