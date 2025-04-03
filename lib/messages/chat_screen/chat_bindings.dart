import 'package:get/get.dart';

import 'chat_controllers.dart';

class ChatBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ChatControllers());
  }

}