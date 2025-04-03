import 'dart:io';
import 'package:collarchek/models/user_home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';


import '../api_provider/api_provider.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';

class DashboardController extends GetxController{
  var searchController =TextEditingController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  final Debouncer debouncer = Debouncer();
  final RxBool isExpanded = false.obs;
  Rx isSearchActive=false.obs;
  Rx location="".obs;
  var userHomeModel=UserHomeModel().obs;
  var userProfileComplatationPercentage=[].obs;


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
    Get.offNamed(AppRoutes.topCompanies,arguments: {argumentTypeData:topCompanies});
  }


  getDashboardApiData() async {
    try {
      progressDialog.show();
      UserHomeModel userHomeData = await ApiProvider.baseWithToken().userDashboard();
      if(userHomeData.status==true){
        userHomeModel.value=userHomeData;
        await writeStorageData(key: profileImage, value: userHomeData.data?.userDetail?.profile.toString()??"");
        await writeStorageData(key: progressPercentage, value: userHomeData.data?.userDetail?.profilePercentage.toString()??"0");
        await writeStorageData(key: searchJype, value: "jobs");

        ///Calculation pending profile Percentage
        print(userHomeModel.value.data!.userDetail!.uncomplete?.length);
        if(userHomeModel.value.data!.userDetail!.uncomplete!=null&&userHomeModel.value.data!.userDetail!.uncomplete!.isNotEmpty){
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Profile Image")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Email Verification")){
            userProfileComplatationPercentage.add("3");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Experience Approved")){
            userProfileComplatationPercentage.add("10");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Education")){
            userProfileComplatationPercentage.add("10");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Skill")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Language")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Review")){
            userProfileComplatationPercentage.add("10");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Resume")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Accomodation")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Country")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Social Media")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Profile Descripton")){
            userProfileComplatationPercentage.add("5");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Certificate")){
            userProfileComplatationPercentage.add("2");
          }
          if(userHomeModel.value.data!.userDetail!.uncomplete!.contains("Certificate")){
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




  unCompletedProfileWidget({required String data}){
    if(data=="Profile Image"){
      Get.offNamed(AppRoutes.profile);
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





  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:dashboard});
  }
  
  

  

}