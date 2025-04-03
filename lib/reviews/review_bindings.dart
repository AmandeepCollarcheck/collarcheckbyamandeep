import 'package:collarchek/reviews/review_controllers.dart';
import 'package:get/get.dart';

class ReviewBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ReviewControllers());
  }

}