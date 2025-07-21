import 'dart:io';

import 'package:collarchek/utills/common_widget/update_profile_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../models/comapny_size_model.dart';
import '../models/company_all_details_data.dart';
import '../models/company_all_employment_model.dart';
import '../models/company_user_details_model.dart';
import '../models/dashboard_statics_model.dart';
import '../models/employee_user_details_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/turn_over_list_model.dart';
import '../models/user_home_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/add_employment_bottom_sheet.dart';
import '../utills/common_widget/common_custom_scrool_tab_view.dart';
import '../utills/common_widget/progress.dart';

class CompanyDashboardControllers extends GetxController{
  var searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  var companyUserDetails=CompanyUserDetailsModel().obs;
  var designationListData=CompanyAllDetailsData().obs;
  var employeeListData=DesignationListModel().obs;
  var companyStaticsDetails=DashboardStaticsDetailsModel().obs;
  var companyEmploymentData=CompanyAllEmploymentModel().obs;
  var userDetails=EmployeeUserDetails().obs;
  Rx isSearchActive=false.obs;
  var userProfileComplatationPercentage=[].obs;
  final BottomNavBarController bottomController = Get.find<BottomNavBarController>();
  var turnoverDetails = <TurnOverListData>[].obs;
  var comanySizeDetails = <CompanySizeList>[].obs;

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
    Future.delayed(Duration(milliseconds: 500), ()async {
      getEmployeeApiCall();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllEmploymentApiCall();
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
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen,
          companyUserDetails: companyUserDetails.value,     turnOverModelDetails: turnoverDetails.value,
          companySizeDetails: comanySizeDetails.value
      );
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
      Get.offNamed(AppRoutes.accountVerification,arguments: {screenName:companyDashboardScreen,isCompanyApp:true});
    }else if(data=="Experience Approved"){
      Get.offNamed(AppRoutes.bottomNavBar);
    }
    else if(data=="Profile Descripton"){
      Get.offNamed(AppRoutes.about);
    }else if(data=="Website"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen,
          companyUserDetails: companyUserDetails.value,index: 0, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    } else if(data=="About Company"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 0, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    }else if(data=="Contact person"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 0, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    }else if(data=="Incorporation Date"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 0, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    }else if(data=="Turnover"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 0, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    }else if(data=="Industry Type"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 0, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    }else if(data=="Country"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 1, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    } else if(data=="State"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 1, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    } else if(data=="City"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 1, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    } else if(data=="Office Address"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 1, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );
    } else if(data=="Social Media"){
      updateProfileBottomSheet(context, companyAllDetails: designationListData.value, screenName: companyDashboardScreen, companyUserDetails: companyUserDetails.value,index: 2, turnOverModelDetails: turnoverDetails.value,companySizeDetails:comanySizeDetails.value );}else if(data=="Add 1 Employee"){
      openAddEmploymentForm(context, designationListData: employeeListData.value, screenNameData: companyDashboardScreen, companyAllEmployment: companyEmploymentData.value, );
    }else if(data=="Add gallery"){
      Get.offNamed(AppRoutes.addGallery,arguments: {screenName:companyDashboardScreen});
    }else if(data=="Add 3 Perks and benefits"||data=="Add 3 Perks and benefits "){
      Get.offNamed(AppRoutes.companyBenefit,arguments: {screenName:companyDashboardScreen});
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


  acceptEmploymentApiCall(context,{required String id})async{
    try {
      progressDialog.show();
      SaveUserProfileModel acceptEmployment = await ApiProvider.baseWithToken().acceptCompanyEmployment(id: id);
      if(acceptEmployment.status==true){
        Future.delayed(Duration(milliseconds: 500), ()async {
          getDashboardStaticeApiData();
        });
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

  rejectEmploymentApiCall(context,{required String id})async{
    try {
      progressDialog.show();
      SaveUserProfileModel acceptEmployment = await ApiProvider.baseWithToken().rejectCompanyEmployment(id: id);
      if(acceptEmployment.status==true){
        Future.delayed(Duration(milliseconds: 500), ()async {
          getDashboardStaticeApiData();
        });
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

  openEmploymentRequestPage(context){
    Get.offNamed(AppRoutes.companyEmploymentRequest,arguments: {screenName:companyDashboardScreen});
  }
  openAllApplicationPage(context){
    Get.offNamed(AppRoutes.applicants,arguments: {screenName:companyDashboardScreen,isAppApplication:true});
  }
  openRecommendedPage(context){
    Get.offNamed(AppRoutes.companyRecommendedEmployee,arguments: {screenName:companyDashboardScreen});
  }
  openViewApplicationPage(context){
    Get.offNamed(AppRoutes.applicants,arguments: {screenName:companyDashboardScreen,isAppApplication:true});
  }
  openRecentlyJoinedPage(context){
    Get.offNamed(AppRoutes.recentlyJoinedPeople,arguments: {screenName:companyDashboardScreen});
  }
  void getEmployeeApiCall() async{
    try {
      progressDialog.show();
      DesignationListModel designationListModel = await ApiProvider.baseWithToken().designationList();
      if(designationListModel.status==true){
        employeeListData.value=designationListModel;

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

  void getAllEmploymentApiCall()async {
    try {
      progressDialog.show();
      CompanyAllEmploymentModel companyAllEmploymentModel = await ApiProvider.baseWithToken().companyAllEmployment();
      if(companyAllEmploymentModel.status==true){
        companyEmploymentData.value=companyAllEmploymentModel;
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