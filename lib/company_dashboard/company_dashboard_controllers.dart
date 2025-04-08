import 'dart:io';

import 'package:collarchek/utills/common_widget/update_profile_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/company_all_details_data.dart';
import '../models/company_user_details_model.dart';
import '../models/dashboard_statics_model.dart';
import '../models/user_home_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/common_custom_scrool_tab_view.dart';
import '../utills/common_widget/progress.dart';

class CompanyDashboardControllers extends GetxController{
  var searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  var companyUserDetails=CompanyUserDetailsModel().obs;
  var designationListData=CompanyAllDetailsData().obs;
  var companyStaticsDetails=DashboardStaticsDetailsModel().obs;
  Rx isSearchActive=false.obs;
  var userProfileComplatationPercentage=[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDashboardApiData();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDashboardStaticeApiData();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDesignationApiCall();
    });
    super.onInit();
  }

  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:companyDashboardScreen});
  }

  getDashboardApiData() async {
    try {
      progressDialog.show();
      CompanyUserDetailsModel companyUserDetailsModel = await ApiProvider.baseWithToken().companyUserDetails();
      if(companyUserDetailsModel.status==true){
        companyUserDetails.value=companyUserDetailsModel;
        await writeStorageData(key: profileImage, value: companyUserDetails.value.data?.profile.toString()??"");
        await writeStorageData(key: progressPercentage, value: companyUserDetails.value.data?.profilePercentage.toString()??"0");
        await writeStorageData(key: searchJype, value: "jobs");

        ///Calculation pending profile Percentage
        if(companyUserDetails.value.data!.uncomplete!=null&&companyUserDetails.value.data!.uncomplete!.isNotEmpty){
          if(companyUserDetails.value.data!.uncomplete!.contains("Profile Image")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Email Verification")){
            userProfileComplatationPercentage.add("3");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Experience Approved")){
            userProfileComplatationPercentage.add("10");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Education")){
            userProfileComplatationPercentage.add("10");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Skill")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Language")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Review")){
            userProfileComplatationPercentage.add("10");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Resume")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Accomodation")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Country")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Social Media")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Profile Descripton")){
            userProfileComplatationPercentage.add("5");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Certificate")){
            userProfileComplatationPercentage.add("2");
          }
          if(companyUserDetails.value.data!.uncomplete!.contains("Certificate")){
            userProfileComplatationPercentage.add("2");
          }

        }

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

  unCompletedProfileWidget(context,{required String data}){
    if(data=="Profile Image"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value);
    }else if(data=="Skill"){
      Get.offNamed(AppRoutes.skills,arguments: {screenName:dashboard});
    }else if(data=="Language"){
      Get.offNamed(AppRoutes.language);
    }else if(data=="Experience"||data=="Experience Approved"){
      Get.offNamed(AppRoutes.employmentHistory,arguments: {screenName:dashboard});
    }else if(data=="Profile Descripton"){
      Get.offNamed(AppRoutes.addPortfolio);
    }else if(data=="Education"){
      Get.offNamed(AppRoutes.educations,arguments: {screenName:dashboard});
    }else if(data=="Certificate"){
      Get.offNamed(AppRoutes.addCertificates);
    }else if(data=="Review"){
      Get.offNamed(AppRoutes.review,arguments: {screenName:dashboard});
    }else if(data=="Email Verification"){
      Get.offNamed(AppRoutes.accountVerification);
    }else if(data=="Experience Approved"){
      Get.offNamed(AppRoutes.bottomNavBar);
    }
    else if(data=="Profile Descripton"){
      Get.offNamed(AppRoutes.about);
    }
    else{
      Get.offNamed(AppRoutes.profile);
    }
  }

  ///Statics Api
  void getDashboardStaticeApiData() async{
    try {
      progressDialog.show();
      DashboardStaticsDetailsModel dashboardStaticsDetailsModel = await ApiProvider.baseWithToken().companyDashboardStatics();
      if(dashboardStaticsDetailsModel.status==true){
        companyStaticsDetails.value=dashboardStaticsDetailsModel;
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




  void getDesignationApiCall() async{
    try {
      progressDialog.show();
      CompanyAllDetailsData designationListModel = await ApiProvider.baseWithToken().companyAllData();
      if(designationListModel.status==true){
        designationListData.value=designationListModel;

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