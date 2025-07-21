import 'package:collarchek/skills/skills_controllers.dart';
import 'package:get/get.dart';

class SkillBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SkillControllers());
  }

}