import 'dart:io';

import 'package:collarchek/models/recommended_job_for_you_model.dart';
import 'package:collarchek/models/user_home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';

class DashboardController extends GetxController{
  var searchController =TextEditingController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  final RxBool isExpanded = false.obs;
  Rx isSearchActive=false.obs;
  Rx location="".obs;
  var userHomeModel=UserHomeModel().obs;


  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDashboardApiData();
    });
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  openRecommendJobPage({bool isJobForYou=false}){
    Get.offNamed(AppRoutes.recommendJob,arguments: {'isJobForYou':isJobForYou});
  }

  openJobDetailsPage({required String jobTitle}){
    Get.offNamed(AppRoutes.jobDetails,arguments: {'jobTitle':jobTitle});
  }
  openTopCompaniesPage(){
    Get.offNamed(AppRoutes.topCompanies);
  }


  getDashboardApiData() async {
    try {
      progressDialog.show();
      UserHomeModel userHomeData = await ApiProvider.baseWithToken().userDashboard();
      if(userHomeData.status==true){
        userHomeModel.value=userHomeData;
        await writeStorageData(key: progressPercentage, value: userHomeData.data?.userDetail?.profilePercentage.toString()??"0");
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