import 'package:collarchek/connections/connection_controllers.dart';
import 'package:get/get.dart';

class ConnectionBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ConnectionControllers());
  }

}