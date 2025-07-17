import 'package:collarchek/job_details/job_details_controller.dart';
import 'package:get/get.dart';

class JobDetailsBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(JobDetailsControllers());
  }

}