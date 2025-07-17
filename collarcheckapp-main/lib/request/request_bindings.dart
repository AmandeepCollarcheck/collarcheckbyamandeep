import 'package:collarchek/request/request_controllers.dart';
import 'package:get/get.dart';

class RequestBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RequestControllers());
  }

}