import 'dart:io';

import 'package:collarchek/utills/common_widget/image_multipart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/all_skills_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class ReviewControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var addSkillsModelData=SaveUserProfileModel().obs;
  var descriptionController =TextEditingController();
  var linkController =TextEditingController();
  Rx ratingValue=0.0.obs;
  Rx skillsId="0".obs;
  var portfolioTitle="Select Portfolio".obs;
  var selectedImageFromTHeGallery="".obs;
  Rx screenNameData="".obs;

  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }
    // TODO: implement onInit
    super.onInit();
  }


  backButtonClick(context){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }

  }



  addReviewValidation(context){
    if ((skillsId.value == "0" || skillsId.value.isEmpty) && ratingValue.value == 0.0) {
      showToast(appPleaseSelecteValidSkills);
    } else if (descriptionController.text.isEmpty) {
      showToast(appGiveReview);
    } else {
      addReviewApiCall(context);
    }

  }



  addReviewApiCall(context)async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      var uploadedData=await convertFileToMultipart(selectedImageFromTHeGallery.value??"");
      var formData = dio.FormData.fromMap({
        "experience":"1",
        "rating":ratingValue??"0",
        "review":descriptionController.text??"",
        "link":linkController.text??"",
        "document[0]":uploadedData??""
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addReview(formData);
      if(addSkillsData.status==true){
        //addSkillsModelData.value=addSkillsData;
        progressDialog.dismissLoader();
        Get.offNamed(AppRoutes.bottomNavBar);

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