import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';

class CompanyProfileControllers extends GetxController with GetTickerProviderStateMixin{
  final scrollController = ScrollController();
  var selectedIndex=0.obs;
  var isExpanded=false.obs;
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey jobOpeningKey = GlobalKey();
  final GlobalKey galleryKey = GlobalKey();
  final GlobalKey companyKey = GlobalKey();
  final GlobalKey similerProfile = GlobalKey();

  var listTabLabel = [
    appAbout, appJobOpening, appGallery
  ].obs;


  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    final contextMap = {
      0: homeKey.currentContext,
      1: jobOpeningKey.currentContext,
      2: galleryKey.currentContext,
    };

    for (int index = 0; index < contextMap.length; index++) {
      final context = contextMap[index];
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero);

        if (offset.dy <= 100 && offset.dy >= -box.size.height / 2) {
          // Change tab when the section is near the top
          if (selectedIndex.value != index) {
            selectedIndex.value = index;
          }
          break;
        }
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  void scrollToSection(int index) {
    final context = [homeKey, jobOpeningKey, galleryKey][index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

}