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
  final List<GlobalKey> sectionKeys = List.generate(4, (_) => GlobalKey());
   late ScrollController scrollController;
   ProgressDialog progressDialog=ProgressDialog() ;
  var jobDetailsData=JobDetailsModel().obs;
  //RxDouble tabViewHeight = RxDouble(350.0);
  //var tabHeight=500.0.obs;
  Rx jobTitle="".obs;
  final RxBool isExpanded = false.obs;
  var isTabClicked = false.obs;





  var selectedIndex=0.obs;
  var listTabLabel = [
    appJobDescription, appRequiredSkills, appJonInformation, appSimilarJobs
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
    scrollController = ScrollController();
    super.onInit();

    final Map<String, dynamic> data = Get.arguments??{};
    if(data.isNotEmpty){
      jobTitle.value=data['jobTitle']??"";
      screenNameData.value=data[screenName]??"";
    }

    scrollController.addListener(_handleScroll);
    Future.delayed(Duration(milliseconds: 500), ()async {
      String jobName=jobTitle.value;
     await getJobDetailsApiData(jobName: jobName??"");
    });
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
  // void updateHeight(double newHeight) {
  //   if (newHeight > tabViewHeight.value) {
  //     tabViewHeight.value = newHeight;
  //   }
  // }





  void scrollToSection(int index)async {
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }



  void _handleScroll() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final context = sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero).dy;

        if (pos <= kToolbarHeight + 280 && pos + box.size.height > kToolbarHeight + 280) {
          if (selectedIndex.value != i) {
            selectedIndex.value = i;
          }
          break;
        }
      }
    }
  }


  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }
}