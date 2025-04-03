import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../models/save_user_profile_model.dart';
import '../models/user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class AccountVerificationControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var userProfileData=UserProfileModel().obs;
  var companyEmailController = TextEditingController();
  var companyPhoneController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getProfileApiCall();
    });
    super.onInit();
  }


  backButtonClick(context){
    Get.offNamed(AppRoutes.bottomNavBar);
  }


  void getProfileApiCall() async{
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
}