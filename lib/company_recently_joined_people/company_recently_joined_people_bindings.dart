import 'package:collarchek/company_recently_joined_people/company_recently_joined_people_controllers.dart';
import 'package:get/get.dart';

class CompanyRecentlyJoinedPeopleBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CompanyRecentlyJoinedPeopleControllers());
  }

}