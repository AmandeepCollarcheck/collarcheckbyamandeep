import 'dart:io';

import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../models/applied_job_data_model.dart';
import '../models/recommended_job_for_you_model.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/progress.dart';

class JobControllers extends GetxController with GetTickerProviderStateMixin{
  var searchController =TextEditingController();
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var userRecommendedJobForYou=RecommendedJobForYouModel().obs;
  var appliedJobs=AppliedJobDataModel().obs;
  Rx isSearchActive=false.obs;
  final RxBool isExpanded = false.obs;

  Rx isJobForYou=true.obs;
  var tabSelectionIndex=0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _handleTab();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getRecommendedApiData();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAppliedJobs();
    });
  }
  var listTabLabel = [
    appJobsForYou,appApplied
  ].obs;
  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:jobs});
  }
  getRecommendedApiData() async{
    try {
      progressDialog.show();
      RecommendedJobForYouModel recommendedJobForYouModel = await ApiProvider.baseWithToken().allJobs(jobType:isJobForYou.value?jobForYou:recommended);
      if(recommendedJobForYouModel.status==true){
        userRecommendedJobForYou.value=recommendedJobForYouModel;
        await writeStorageData(key: searchJype, value: "jobs");
      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }



  void getAppliedJobs() async{
    try {
      progressDialog.show();
      AppliedJobDataModel recommendedJobForYouModel = await ApiProvider.baseWithToken().appliedJobs();
      if(recommendedJobForYouModel.status==true){
        appliedJobs.value=recommendedJobForYouModel;
        await writeStorageData(key: searchJype, value: "jobs");
      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }


  openJobDetails({required String jobTitle}){
    Get.offNamed(AppRoutes.jobDetails,arguments: {'jobTitle':jobTitle,screenName:jobs});
  }


  void shortDataList({required int value}) {
    var jobList = userRecommendedJobForYou.value.data?.alljobList;

    if (jobList == null || jobList.isEmpty) return; // Ensure list is not null or empty

    if (value == 1) {
      // Sort by Most Relevant (if needed)
    } else if (value == 2) {
      jobList.sort((a, b) =>
          (double.tryParse(b.salary ?? '0') ?? 0.0)
              .compareTo(double.tryParse(a.salary ?? '0') ?? 0.0)
      );
    } else if (value == 3) {
      jobList.sort((a, b) =>
          (double.tryParse(a.salary ?? '0') ?? 0.0)
              .compareTo(double.tryParse(b.salary ?? '0') ?? 0.0)
      );
    } else {
      jobList.sort((a, b) {
        DateTime dateA = parseDate(a.createDate);
        DateTime dateB = parseDate(b.createDate);
        return dateB.compareTo(dateA); // Newest first
      });
    }

    /// 🔄 Convert to List to trigger UI update
    userRecommendedJobForYou.value.data?.alljobList = jobList.toList();

    /// 🔄 Refresh GetX observable
    userRecommendedJobForYou.refresh();
  }
  /// ✅ Date Parsing Helper Function
  DateTime parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return DateTime(2000);
    try {
      return DateTime.parse(dateString); // Format: "2025-03-10 17:03:29"
    } catch (e) {
      return DateTime(2000); // Default fallback date
    }
  }

  _handleTab() async {
    final BottomNavBarController controller = Get.find<BottomNavBarController>();
    tabController.index=controller.selectedTabIndexValue.value;
    update();
  }


}