
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
  void handleScroll() {
    if (isTabClicked) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSectionOffsets();
      final scrollOffset = scrollController.offset;
      for (int i = 0; i < sectionOffsets.length; i++) {
        //sectionOffsets=[370.43999999999994, 1374.44, 1618.44]
        final start = sectionOffsets[i];
        final end = (i + 1 < sectionOffsets.length) ? sectionOffsets[i + 1] : double.infinity;
        print("OOOooooooooooOOOOOO");
        print(start);//1274.6666666666665
        print(end);//1518.6666666666665
        print("OOOooooooooooOOOOOO111111");
        if (scrollOffset >= start && scrollOffset < end) {
          print("asdlaksdalsdkalksdajklsdajklds1111$i");
          if (selectedIndex.value != i) {
            print("asdlaksdalsdkalksdajklsdajklds3222222$i");
            print("asdlaksdalsdkalksdajklsdajklds333333${selectedIndex.value}");
            selectedIndex.value = i;
          }
          break;
        }
      }
    });

  }


  void _updateSectionOffsets() {
    sectionOffsets.clear();
    for (var key in sectionKeys) {
      final ctx = key.currentContext;
      print('>>>>>>>>>>>>>>>>');
      if (ctx != null) {
        print('>>>>>>>>>>>>>>>>111111');
        final box = ctx.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: buildContext?.findRenderObject());
        print('>>>>>>>>>>>>>>>>2222222');
        sectionOffsets.add(position.dy + scrollController.offset);
        print('>>>>>>>>>>>>>>>>333333');
        print(sectionOffsets);
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

