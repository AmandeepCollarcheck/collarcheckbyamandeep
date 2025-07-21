import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommonScrollControllers extends GetxController with GetTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  final List<GlobalKey> sectionKeys = List.generate(3, (_) => GlobalKey());
  final List<double> sectionOffsets = [];
  final selectedIndex = 0.obs;

  bool isTabClicked = false;
  BuildContext? scrollViewContext;

  double lastOffset = 0.0;
  Timer? debounceTimer;



  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(handleScroll);
  }

  @override
  void onReady() {
    super.onReady();
    if (scrollViewContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateSectionOffsets(scrollViewContext!);
      });
    }
  }

  void handleScroll() {
    if (isTabClicked || sectionOffsets.isEmpty) return;

    debounceTimer?.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 100), () {
      final scrollOffset = scrollController.offset;
      lastOffset = scrollOffset;
      for (int i = sectionOffsets.length - 1; i >= 0; i--) {
        if (scrollOffset + 50 >= sectionOffsets[i]) {
          if (selectedIndex.value != i) {
            selectedIndex.value = i;
          }
          break;
        }
      }
    });
  }

  void updateSectionOffsets(BuildContext context) {
    sectionOffsets.clear();
    for (var key in sectionKeys) {
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final scrollContainerBox = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: scrollContainerBox);
        sectionOffsets.add(position.dy);
      }
      print("?????????????????");
      print(sectionOffsets);
    }
  }


  void scrollToSection(int index) {
    isTabClicked = true;
    final ctx = sectionKeys[index].currentContext;
    print("asshdjfshdfhsdfsdfhf");
    print(ctx);
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 200), () {
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
    debounceTimer?.cancel();
    super.dispose();
  }
}
