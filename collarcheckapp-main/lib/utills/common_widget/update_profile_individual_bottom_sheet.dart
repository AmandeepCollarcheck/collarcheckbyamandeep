
import 'package:collarchek/utills/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../profiles/profile_controllers.dart';
import '../../profiles/profile_dart.dart';

individualUpdateProfileBottomSheet(context){
  if (!Get.isRegistered<ProfileControllers>()) {
    Get.put(ProfileControllers());
  }
  return  Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*0.9,
        decoration: BoxDecoration(
          color: appWhiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: ProfilePage(),
      ),
    isScrollControlled: true
  );
}

