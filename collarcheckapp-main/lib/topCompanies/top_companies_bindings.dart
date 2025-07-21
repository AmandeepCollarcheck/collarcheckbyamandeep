import 'package:collarchek/topCompanies/top_companies_controller.dart';
import 'package:get/get.dart';

class TopCompaniesBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TopCompaniesController());
  }

}