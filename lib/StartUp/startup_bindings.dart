import 'package:collarchek/StartUp/startup_controller.dart';
import 'package:get/get.dart';

class StartUpBindings extends Bindings{
  @override
  void dependencies() {
    //Get.lazyPut<StartUpControllers>(() => StartUpControllers());
    Get.put(StartUpControllers());
  }
}