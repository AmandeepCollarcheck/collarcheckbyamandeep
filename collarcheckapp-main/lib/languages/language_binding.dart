import 'package:collarchek/languages/language_controllers.dart';
import 'package:get/get.dart';

class LanguageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LanguageControllers());
  }

}