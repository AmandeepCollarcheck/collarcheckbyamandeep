import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabScrollController extends GetxController {
  late ScrollController scrollController;
  late TabController tabController;
  RxInt currentIndex = 0.obs;

  final sectionKeys = List<GlobalKey>.generate(3, (_) => GlobalKey());

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    tabController = TabController(length: 3, vsync: ScrollableState(), initialIndex: currentIndex.value);

    // Scroll listener for changing tabs based on scroll
    scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final context = sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero).dy;

        if (pos <= kToolbarHeight + 80 && pos + box.size.height > kToolbarHeight + 80) {
          if (currentIndex.value != i) {
            currentIndex.value = i;
            tabController.animateTo(i);  // This will update TabController
          }
          break;
        }
      }
    }
  }

  void scrollToSection(int index) {
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
