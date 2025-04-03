import 'dart:io';

import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';

class AboutControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var descriptionController =TextEditingController();
  var titleController =TextEditingController();
  var screenNameData="".obs;
  var isEditData=false.obs;
  var filledProfileDescription="".obs;

  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      isEditData.value=data[isEdit]??false;
      filledProfileDescription.value=data[filledProfileDescriptionData]??"";

    }
    if(isEditData.value){
      filledProfileDescription.value==data[filledProfileDescriptionData]??"";
      descriptionController.text=filledProfileDescription.value;
    }

    super.onInit();
  }

  backButtonClick(){
    if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }


  validateAbout(context){
    if(descriptionController.text.isNotEmpty) {
      _abouProfileApiCall(context);
    } else {
      showToast(appPleaseAddProfileDescription);
    }

  }



  void _abouProfileApiCall(context) async{
    try {
      keyboardDismiss(context);
      progressDialog.show();
      var fNameData=await readStorageData(key: firstName);
      var formData = dio.FormData.fromMap({
        "fname":fNameData,
        "profile_description":descriptionController.text??"",
      });
      SaveUserProfileModel saveUserProfileModel = await ApiProvider.baseWithToken().saveUserProfile(formData);
      if(saveUserProfileModel.status==true){
        progressDialog.dismissLoader();
        Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});

      }else{
        showToast(saveUserProfileModel.messages??"");
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