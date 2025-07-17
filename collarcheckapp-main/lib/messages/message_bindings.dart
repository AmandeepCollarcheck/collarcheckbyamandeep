import 'package:collarchek/messages/message_controllers.dart';
import 'package:get/get.dart';

class MessageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MessageControllers());
  }

}