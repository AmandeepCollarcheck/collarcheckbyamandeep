import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/job_details_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class JobDetailsControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  final ScrollController scrollController = ScrollController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  var jobDetailsData=JobDetailsModel().obs;
  RxDouble tabViewHeight = RxDouble(350.0);
  //var tabHeight=500.0.obs;
  Rx jobTitle="".obs;
  final RxBool isExpanded = false.obs;
  var isTabClicked = false.obs;


  final List<GlobalKey> keys = List.generate(3, (index) => GlobalKey(debugLabel: 'section_$index'));

  final List<double> sectionOffsets = [];
  


  var listTabLabel = [
    appJobDescription, appRequiredSkills, appJonInformation
  ].obs;
  var jobDescriptionTitle = [
    "Job Description", "Roles and Responsibilities"
  ].obs;
  var jobDescription = [
    "Wipro Limited (NYSE: WIT, BSE: 507685, NSE: WIPRO) is a leading technology services and consulting company focused on building innovative solutions that address clients’ most complex digital transformation needs. Leveraging our holistic portfolio of capabilities in consulting, design, engineering, and operations, we help clients realize their boldest ambitions and build future-ready, sustainable businesses. With over 230,000 employees and business partners across 65 countries, we deliver on the promise of helping our clients, colleagues, and communities thrive in an ever-changing world. For additional information, visit us at www.wipro.com", "Wipro Limited (NYSE: WIT, BSE: 507685, NSE: WIPRO) is a leading technology services and consulting company focused on building innovative solutions that address clients’ most complex digital transformation needs. Leveraging our holistic portfolio of capabilities in consulting, design, engineering, and operations, we help clients realize their boldest ambitions and build future-ready, sustainable businesses. With over 230,000 employees and business partners across 65 countries, we deliver on the promise of helping our clients, colleagues, and communities thrive in an ever-changing world. For additional information, visit us at www.wipro.com"
  ].obs;

  var screenNameData="".obs;
  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> data = Get.arguments??{};
    jobTitle.value=data['jobTitle']??"";
    screenNameData.value=data[screenName]??"";
    tabController = TabController(length: 3, vsync: this);
    scrollController.addListener(_handleScroll);

    Future.delayed(Duration(milliseconds: 500), ()async {
      String jobName=jobTitle.value;
     await getJobDetailsApiData(jobName: jobName??"");
    });
  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }


  backButtonClick(context){
    if(screenNameData.value==jobs){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"2"});
    }else if(screenNameData.value==searchScreen){
      Get.offNamed(AppRoutes.search);
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }


  openJobDetailsPage({required String jobTitle}){
    Get.offNamed(AppRoutes.jobDetails,arguments: {'jobTitle':jobTitle});
  }
   getJobDetailsApiData({required String  jobName}) async{
    try {
      progressDialog.show();
      JobDetailsModel jobDetailsModel = await ApiProvider.baseWithToken().jobDetails(jobName: jobName);
      if(jobDetailsModel.status==true){
        jobDetailsData.value=jobDetailsModel;

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

 


  applyJob(context)async{
    try {
      progressDialog.show();
      var jobId=jobDetailsData.value.data?.detail?.id??"";
      print("sslkjkdfskjfshfdhsjdfk");
      print(jobId);
      var formData = dio.FormData.fromMap({
        "job":jobId,

      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().applyJob(formData);
      if(addSkillsData.status==true){
        await getJobDetailsApiData(jobName: jobTitle.value??"");


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
  void updateHeight(double newHeight) {
    if (newHeight > tabViewHeight.value) {
      tabViewHeight.value = newHeight;
    }
  }





  void _handleScroll() {
    if (isTabClicked.value) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSectionOffsets();
      final scrollOffset = scrollController.offset;

      for (int i = 0; i < sectionOffsets.length; i++) {
        final start = sectionOffsets[i];
        final end = (i + 1 < sectionOffsets.length) ? sectionOffsets[i + 1] : double.infinity;

        if (scrollOffset >= start && scrollOffset < end) {
          if (tabController.index != i) {
            tabController.animateTo(i);
          }
          break;
        }
      }
    });
  }

  void _updateSectionOffsets() {
    sectionOffsets.clear();
    for (var key in keys) {
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: Get.context!.findRenderObject());
        sectionOffsets.add(position.dy + scrollController.offset);
      }
    }
  }

  void scrollToSection(int index) {
    isTabClicked.value = true;
    final ctx = keys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        Future.delayed(Duration(milliseconds: 200), () {
          isTabClicked.value = false;
        });
      });
    } else {
      isTabClicked.value = false;
    }
  }


  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }
}