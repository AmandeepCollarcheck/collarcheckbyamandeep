import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/job_details_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class JobDetailsControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var jobDetailsData=JobDetailsModel().obs;
  Rx jobTitle="".obs;
  final RxBool isExpanded = false.obs;
  double tabViewHeight = 500; // Default height

  final GlobalKey tabViewKey = GlobalKey();


  var listTabLabel = [
    appJobDescription, appRequiredSkills, appJonInformation
  ].obs;
  var jobDescriptionTitle = [
    "Job Description", "Roles and Responsibilities"
  ].obs;
  var jobDescription = [
    "Wipro Limited (NYSE: WIT, BSE: 507685, NSE: WIPRO) is a leading technology services and consulting company focused on building innovative solutions that address clients’ most complex digital transformation needs. Leveraging our holistic portfolio of capabilities in consulting, design, engineering, and operations, we help clients realize their boldest ambitions and build future-ready, sustainable businesses. With over 230,000 employees and business partners across 65 countries, we deliver on the promise of helping our clients, colleagues, and communities thrive in an ever-changing world. For additional information, visit us at www.wipro.com", "Wipro Limited (NYSE: WIT, BSE: 507685, NSE: WIPRO) is a leading technology services and consulting company focused on building innovative solutions that address clients’ most complex digital transformation needs. Leveraging our holistic portfolio of capabilities in consulting, design, engineering, and operations, we help clients realize their boldest ambitions and build future-ready, sustainable businesses. With over 230,000 employees and business partners across 65 countries, we deliver on the promise of helping our clients, colleagues, and communities thrive in an ever-changing world. For additional information, visit us at www.wipro.com"
  ].obs;
  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> data = Get.arguments;
    jobTitle.value=data['jobTitle'];
    tabController = TabController(length: 3, vsync: this);
    Future.delayed(Duration(milliseconds: 500), ()async {
      String jobName=jobTitle.value;
      getJobDetailsApiData(jobName: jobName??"");
    });
  }
  openJobDetailsPage({required String jobTitle}){
    Get.offNamed(AppRoutes.jobDetails,arguments: {'jobTitle':jobTitle});
  }
  void getJobDetailsApiData({required String  jobName}) async{
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
}