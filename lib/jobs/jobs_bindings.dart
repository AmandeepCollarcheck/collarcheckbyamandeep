import 'package:collarchek/jobs/jobs_controllers.dart';
import 'package:get/get.dart';

class JobsBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(JobControllers());
  }

}