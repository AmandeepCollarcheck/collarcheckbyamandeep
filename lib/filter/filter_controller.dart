import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';

class FilterController extends GetxController with GetTickerProviderStateMixin {
  late final TabController tabController;
  var searchController = TextEditingController();

  var listTabLabel = [
    appSelectCompany, appSelectIndustry, appSelectDepartment
  ].obs;

  var selectCompanyListOption = [
    "Webx pvt ltd", "SMM UNG", "Narula Exports", "SP Humans pvt ltd"
  ].obs;
  var filterTypeLabel = [
    "Select Company", "Select Industry", "Select Department"
  ].obs;

  // ✅ Make list reactive
  var isSelectedFilterOption = <String, RxList<bool>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    for (var label in filterTypeLabel) {
      isSelectedFilterOption[label] = RxList<bool>.filled(selectCompanyListOption.length, false);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void clickFilterClose() {
    Get.offNamed(AppRoutes.recommendJob);
  }
}
