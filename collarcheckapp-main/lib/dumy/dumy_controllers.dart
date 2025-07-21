import 'package:get/get.dart';

class TabControllerX extends GetxController {
  // This will store the index of the selected tab
  var selectedIndex = 0.obs;

  // Function to update the tab index
  void updateTabIndex(int index) {
    selectedIndex.value = index;
  }
}