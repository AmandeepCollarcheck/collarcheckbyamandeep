import 'package:collarchek/certificates/certificates_controllers.dart';
import 'package:get/get.dart';

class CertificatesBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CertificatesControllers());
  }

}