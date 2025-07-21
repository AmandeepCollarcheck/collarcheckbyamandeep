import 'package:collarchek/recommendJobs/recommend_job_controller.dart';
import 'package:get/get.dart';

class RecommendJobBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RecommendJobController());
  }

}