import 'package:collarchek/dashboard/dashboard_page.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/commonDrawer.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utills/app_key_constent.dart';

class BottomNavBarController extends GetxController{
  final ScrollController scrollController = ScrollController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx isNavBarVisible = true.obs;
  Rx bottomNavCurrentIndex=0.obs;
  Rx profilePercentage=0.0.obs;
  var profileImageData="".obs;
  var nameInitial="".obs;
  var selectedTabIndexValue=0.obs;
  var userTypeData="".obs;
  var selectedUserType=false.obs;
  var isProfileDataLoaded = false.obs;
  var profileName="".obs;
  @override
  void onInit() {

    Map<String, dynamic> data = Get.arguments ?? {};
    if (data.isNotEmpty) {
      int? index = int.tryParse(data[bottomNavCurrentIndexData]?.toString() ?? '0');
      bottomNavCurrentIndex.value = index ?? 0;
    }
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
    _getProfilePercentage();
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  selectBottomNavOption(context,{required int selectedIndex}){
    bottomNavCurrentIndex.value=selectedIndex;
  }
  final List<String> routes = [
    '/home',
    '/connections',
    '/jobs',
    '/messages',
    '/profile',
  ];

  final List<String> companyRoutes = [
    '/companyDashboard',
    '/companyEmployees',
    '/companyJobs',
    '/messages',
    '/companyProfile',
  ];

  void _getProfilePercentage() async{
    userTypeData.value=await readStorageData(key: userType);
    if(userTypeData.value==company){
      selectedUserType.value=true;
    }else{
      selectedUserType.value=false;
    }


    final data = await readStorageData(key: progressPercentage) ?? '0';
    profilePercentage.value = (double.tryParse(data) ?? 0.0) / 100;

    //profilePercentage.value = readStorageData(key: progressPercentage)!=null?(double.tryParse(await readStorageData(key: progressPercentage)) ?? 0.0) / 100:0.0;




    profileImageData.value=await readStorageData(key: profileImage);
    var userFirstName=await readStorageData(key: firstName);
    var userLastName=await readStorageData(key: lastName);
    profileName.value="$userFirstName";

    nameInitial.value= getInitialsWithSpace(input: "$userFirstName $userLastName");
    update();
    isProfileDataLoaded.value = true;
  }


}