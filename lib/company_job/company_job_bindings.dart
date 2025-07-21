import 'package:collarchek/company_job/company_job_controllers.dart';
import 'package:get/get.dart';

class CompanyJobBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyJobControllers());
  }

}