import 'package:collarchek/all_review/all_review_controllers.dart';
import 'package:get/get.dart';

class AllReviewBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AllReviewControllers());
  }

}