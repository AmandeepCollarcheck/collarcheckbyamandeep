import 'package:collarchek/about/about_controllers.dart';
import 'package:get/get.dart';

class AboutBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AboutControllers());
  }

}