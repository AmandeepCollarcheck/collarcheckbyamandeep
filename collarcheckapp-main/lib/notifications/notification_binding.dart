import 'package:collarchek/notifications/notifications_controllers.dart';
import 'package:get/get.dart';

class NotificationBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NotificationControllers());
  }

}