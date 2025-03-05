import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';

class ConnectionControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  var listTabLabel = [
    appFollowersText,appFollowing
  ].obs;
}