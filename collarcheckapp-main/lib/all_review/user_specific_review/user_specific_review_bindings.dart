import 'package:collarchek/all_review/user_specific_review/user_specfic_review_controllers.dart';
import 'package:get/get.dart';

class UserSpecificReviewBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(UserSpecificReviewControllers());
  }

}