
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_key_constent.dart';



class CommonScrollControllers extends GetxController with GetTickerProviderStateMixin{
  final ScrollController scrollController = ScrollController();


  final List<GlobalKey> sectionKeys = List.generate(3, (_) => GlobalKey());
  final List<double> sectionOffsets = [];
  final selectedIndex = 0.obs;

  bool isTabClicked = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(handleScroll);
  }
  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use your scrollable ListView's context here
      _updateSectionOffsets(scrollViewContext!);
    });
  }


  double lastOffset = 0.0;

  void handleScroll() {
    if (isTabClicked) return;

    final scrollOffset = scrollController.offset;
    final isScrollingDown = scrollOffset > lastOffset;
    lastOffset = scrollOffset;

    for (int i = 0; i < sectionOffsets.length; i++) {
      final start = sectionOffsets[i];
      final end = (i + 1 < sectionOffsets.length) ? sectionOffsets[i + 1] : double.infinity;

      if (scrollOffset >= start && scrollOffset < end) {
        if (selectedIndex.value != i) {
          selectedIndex.value = i;
          print('User scrolled ${isScrollingDown ? 'down' : 'up'} to section $i');
        }
        break;
      }
    }
  }




  void _updateSectionOffsets(BuildContext context) {
    sectionOffsets.clear();

    for (var key in sectionKeys) {
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final scrollContainerBox = context.findRenderObject() as RenderBox;

        final position = box.localToGlobal(Offset.zero, ancestor: scrollContainerBox);
        sectionOffsets.add(position.dy); // relative to scroll container
      }
    }
  }


  void scrollToSection(int index) {
    isTabClicked = true;
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        Future.delayed(Duration(milliseconds: 200), () {
          isTabClicked = false;
        });
      });
    } else {
      isTabClicked = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

