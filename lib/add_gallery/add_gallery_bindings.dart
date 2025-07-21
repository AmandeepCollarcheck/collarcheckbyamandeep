import 'package:collarchek/add_gallery/add_gallery_controllers.dart';
import 'package:get/get.dart';

class AddGalleryBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AddGalleryControllers());
  }

}