import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../models/company_profile_details_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class AccountVerificationControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var userProfileData=UserProfileModel().obs;
  var companyProfileData=CompanyProfileDetailsModel().obs;
  var companyEmailController = TextEditingController();
  var companyPhoneController = TextEditingController();
  var screenNameData="".obs;
  var isCompanyAppData=false.obs;
  var isPhoneVerified="".obs;
  var isEmailVerified="".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      isCompanyAppData.value=data[isCompanyApp]??false;

    }
    if(isCompanyAppData.value){
      Future.delayed(Duration(milliseconds: 500), ()async {
        getCompanyProfileApiCall();
      });
    }else{
      Future.delayed(Duration(milliseconds: 500), ()async {
        getIndividualProfileApiCall();
      });
    }

    super.onInit();
  }


  backButtonClick(context){
    if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:'0'});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }


  void getIndividualProfileApiCall() async{
    try {
      progressDialog.show();
      String firstname =await GetStorage().read(firstName);
      String lastname =await GetStorage().read(lastName);
      String slugData =await GetStorage().read(slug);
      final userName=("$firstname-$lastname").replaceAll(" ", "");
      UserProfileModel userProfileModel = await ApiProvider.baseWithToken().userProfile(userName: slugData);
      if(userProfileModel.status==true){
        userProfileData.value=userProfileModel;
        companyEmailController.text=userProfileData.value.data?.email??"";
        companyPhoneController.text=userProfileData.value.data?.phone??"";
         isPhoneVerified.value=userProfileData.value.data?.phoneVerified??"";
         isEmailVerified.value=userProfileData.value.data?.emailVerified??"";
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

  verifyEmailIdApiCall()async{
    try {
      progressDialog.show();
      var params={
        "email":companyEmailController.text??""
      };
      SaveUserProfileModel emailVerify = await ApiProvider.baseWithToken().verifyEmail(params);
      if(emailVerify.status==true){
        showToast(emailVerify.messages??'');
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Close dialog
        }
        Get.offNamed(AppRoutes.otp,arguments: {mobileNumber:companyEmailController.text??"",isEmailVerification:true,screenName:dashboard});
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

  void getCompanyProfileApiCall() async{
    try {
      progressDialog.show();
      String slugData =await GetStorage().read(slug);
      CompanyProfileDetailsModel companyProfileDetailsModel = await ApiProvider.baseWithToken().companyProfile(userName: slugData);
      if(companyProfileDetailsModel.status==true){
        companyProfileData.value=companyProfileDetailsModel;

        companyEmailController.text=companyProfileData.value.data?.email??"";
        companyPhoneController.text=companyProfileData.value.data?.phone??"";
        isPhoneVerified.value=companyProfileData.value.data?.phoneVerified??"";
        isEmailVerified.value=companyProfileData.value.data?.emailVerified??"";
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