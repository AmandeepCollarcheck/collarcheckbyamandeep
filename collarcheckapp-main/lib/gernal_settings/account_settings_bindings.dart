import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'account_settings_controller.dart';

class AccountSettingsBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AccountSettingController());
  }

}